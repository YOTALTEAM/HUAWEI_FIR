
#include <fstream>
#include <iostream>
#include <iomanip>
#include <cstdlib>

#include "transform.h"
#include "evaluation.h"
#include "convolution.h"

using namespace dsplib;

int main() {

    int n = 32;
    // int n = 1024;
    // int n = 4096;
/*
    Part 0. FIR data Generation
*/
    // Generate input sequence
    vfp xseq(n, 0);
    for(int i = 0; i < n; i++) {
        xseq[i] = ((nfp) (rand() % (1 << 14))) / (1 << 16);
        if((int) rand() % 2) xseq[i] = -xseq[i];
    }

    // Assign tapping coefficients of FIR
    vfp tap(n, 0);
    for(int i = 0; i < n; i++) {
        tap[i] = ((nfp) (rand() % (1 << 14))) / (1 << 16);
        if((int) rand() % 2) tap[i] = -tap[i];
    }

/*
    Part 1. Direct FIR
    -> fir_o = xseq * tap
*/
    // FIR output
    auto fir_o = conv::fir_regular(xseq, tap);
    std::cout << ">> FIR output: " << std::endl;
    for(int i = 0; i < fir_o.size(); i++) {
        std::cout << " | " << fir_o[i];
    }std::cout << std::endl;

/*
    Part 2. FIR by DFT
    -> dft_o = IDFT(DFT(xseq) .* DFT(tap))
*/
    // DFT(xseq)
    auto cxseq = vfp_2_cvfp(xseq, 2*n);
    auto cxseq_t = trans::dft_forward(cxseq);

    // DFT(tap)
    auto ctap = vfp_2_cvfp(tap, 2*n);
    auto ctap_t = trans::dft_forward(ctap);

    // point-wise multiplication between DFT(xseq) & DFT(tap)
    cvfp mult_t(2*n);
    for(int i = 0; i < 2*n; i++) {
        mult_t[i] = cxseq_t[i] * ctap_t[i];
    }

    // IDFT(DFT(xseq) .* DFT(tap))
    auto cdft_o = trans::dft_backward(mult_t);
    auto dft_o = cvfp_2_vfp(cdft_o, 2*n, "real");
    std::cout << ">> IDFT(DFT(xseq).*DFT(tap)): " << std::endl;
    for(int i = 0; i < dft_o.size(); i++) {
        std::cout << " | " << dft_o[i];
    }std::cout << std::endl;

/*
    Part 3. FIR by FFT
    -> fft_o = IFFT(DFT(xseq) .* FFT(tap))
*/
    // DFT(xseq)
    auto cxseq_ft = trans::fft_forward(cxseq);

    // DFT(tap)
    auto ctap_ft = trans::fft_forward(ctap);

    // point-wise multiplication between FFT(xseq) & FFT(tap)
    cvfp mult_ft(2*n);
    for(int i = 0; i < 2*n; i++) {
        mult_ft[i] = cxseq_ft[i] * ctap_ft[i];
    }

    // IDFT(DFT(xseq) .* DFT(tap))
    auto cfft_o = trans::fft_backward(mult_ft);
    auto fft_o = cvfp_2_vfp(cfft_o, 2*n, "real");
    std::cout << ">> IDFT(DFT(xseq).*DFT(tap)): " << std::endl;
    for(int i = 0; i < fft_o.size(); i++) {
        std::cout << " | " << fft_o[i];
    }std::cout << std::endl;

/*
    Part 4. Error Evaluation
*/
    // Error Evaluation
    double eval_L_2 = eval::L_2_error(fir_o, dft_o);
    std::cout << ">> The L_2 error between the output of DFT and FIR is : " << std::endl;
    std::cout << " | " << eval_L_2 << std::endl;
    eval_L_2 = eval::L_2_error(fir_o, fft_o);
    std::cout << ">> The L_2 error between the output of FFT and FIR is : " << std::endl;
    std::cout << " | " << eval_L_2 << std::endl;

    int Qlen = 4;
    auto cQxseq = cvfp_2_cvQfix(cxseq, Qlen, 2*n);
    auto cQxseq_ft = trans::fft_forward(cQxseq);
    // std::cout << "?????: " << cQxseq_ft[0].real.getQval() << std::endl;
    auto cxseq_ft2 = cvQfix_2_cvfp(cQxseq_ft, 2*n);
    eval_L_2 = eval::L_2_error(cvfp_2_vfp(cxseq_ft, 2*n, "real"), cvfp_2_vfp(cxseq_ft2, 2*n, "real"));
    std::cout << ">> The L_2 error of FFT quantization: " << std::endl;
    std::cout << " | " << eval_L_2 << std::endl;

    return 0;
}