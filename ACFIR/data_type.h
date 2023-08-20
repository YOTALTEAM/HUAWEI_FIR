
#ifndef DATA_TYPE_H
#define DATA_TYPE_H

#include <inttypes.h>
#include <vector>
#include <complex>
#include <cmath>
#include <iostream>

namespace dsplib{
    const double pi = acos(-1.0);

    // typedef unsigned int u32;

    typedef double nfp;
    typedef std::complex<double> cnfp;
    typedef std::vector<nfp>  vfp; // full precision vector
    typedef std::vector<cnfp> cvfp; // full precision complex vector
    class Qfix{
        public:
            Qfix();
            Qfix(int value, int length);
            int getQlen () const;
            int getQval () const;
            Qfix operator+ (const Qfix &b);
            Qfix operator- (const Qfix &b);
            Qfix operator* (const Qfix &b);
            friend std::ostream& operator<<(std::ostream & o, const Qfix& b);
        private:
            int val; // value
            int len; // data width (integer + fraction)
    };
    class cQfix{
        public:
            Qfix real;
            Qfix imag;
            cQfix();
            cQfix(Qfix realQfix, Qfix imagQfix);
            cQfix operator+ (const cQfix &b);
            cQfix operator- (const cQfix &b);
            cQfix operator* (const cQfix &b);
            friend std::ostream& operator<<(std::ostream & o, const cQfix& b);
    };

    typedef std::vector<Qfix> vQfix;
    typedef std::vector<cQfix> cvQfix;
    /**
     * @brief Extend real vector to complex vector
     * @param vi Input real vector
     * @param len Expected output length 
     **/
    cvfp vfp_2_cvfp(const vfp& vi, int len);
    /**
     * @brief Decompose the real and imaginary part of a complex vector 
     * @param vi Input complex vector
     * @param len Expected output length 
     * @param 
     **/
    std::vector<vfp> cvfp_2_vfp(const cvfp& vi, int len);
    vfp cvfp_2_vfp(const cvfp& vi, int len, const char* type);
    /**
     * @brief Decompose the real and imaginary part of a complex vector 
     * @param vi Input complex vector
     * @param len Expected output length 
     * @param 
     **/
    vQfix vfp_2_vQfix(const vfp& vi, int Qlen, int len);
    cvQfix cvfp_2_cvQfix(const cvfp& vi, int Qlen, int len);
    cvfp cvQfix_2_cvfp(const cvQfix& vi, int len);
};

#endif