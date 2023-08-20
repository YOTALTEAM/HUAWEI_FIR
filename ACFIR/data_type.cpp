
#include <vector>
#include <complex>
#include <cmath>
#include "data_type.h"

namespace dsplib{

    Qfix::Qfix() : 
        val(0), len(16) {}
    Qfix::Qfix(int value, int length) : 
        val(value & ((2 << length) - 1)), len(length) {}
    int Qfix::getQlen() const {
        return this->len;
    }
    int Qfix::getQval() const {
        return this->val;
    }
    Qfix Qfix::operator+ (const Qfix &b) {
        Qfix sum(0, this->len);
        int dlen = this->len - b.len;
        int dval = dlen > 0 ? b.val << dlen : b.val >> (-dlen);
        sum.val = (this->val + dval) & ((2 << this->len) - 1);
        return sum;
    }
    Qfix Qfix::operator- (const Qfix &b) {
        Qfix diff(0, this->len);
        int dlen = this->len - b.len;
        int dval = dlen > 0 ? b.val << dlen : b.val >> (-dlen);
        diff.val = (this->val - dval) & ((2 << this->len) - 1);
        return diff;
    }
    Qfix Qfix::operator* (const Qfix &b) {
        Qfix dot(0, this->len);
        int mask0 = (1 << this->len) - 1;
        int mask1 = (1 << b.len) - 1;
        int v0 = ((this->val & mask0) << 1) - this->val;
        int v1 = ((b.val & mask1) << 1) - b.val;
        dot.val = ((v0 * v1) >> b.len) & ((mask0 << 1) + 1);
        return dot;
    }
    std::ostream& operator<<(std::ostream & o, const Qfix& b){
        o << ((b.val >> b.len) & 1) << ".";
        for(int i = 0; i < b.len; i++){
            o << ((b.val >> (b.len - 1 - i)) & 1);
        }
        return o;
    }
    cQfix::cQfix() : 
        real(Qfix()), imag(Qfix()) {}
    cQfix::cQfix(Qfix realQfix, Qfix imagQfix) : 
        real(realQfix), imag(imagQfix) {}
    cQfix cQfix::operator+ (const cQfix &b) {
        cQfix sum(this->real + b.real, this->imag + b.imag);
        return sum;
    }
    cQfix cQfix::operator- (const cQfix &b) {
        cQfix diff(this->real - b.real, this->imag - b.imag);
        return diff;
    }
    cQfix cQfix::operator* (const cQfix &b) {
        cQfix dot((this->real * b.real) - (this->imag * b.imag), (this->real * b.imag) + (this->imag * b.real));
        return dot;
    }
    std::ostream& operator<<(std::ostream & o, const cQfix& b){
        o << "(" << b.real << ", " << b.imag << ")";
        return o;
    }

    // Vector representation transform
    cvfp vfp_2_cvfp(const vfp& vi, int len) {
        cvfp vo(len, {0, 0});
        for(int i = 0; i < len; i++) {
            if(i < vi.size()) {
                vo[i].real(vi[i]);
                vo[i].imag(0);
            }
        }
        return vo;
    }

    std::vector<vfp> cvfp_2_vfp(const cvfp& vi, int len) {
        std::vector<vfp> vo(2);
        for(int i = 0; i < len; i++) {
            if(i < vi.size()) {
                vo[0].push_back(vi[i].real());
                vo[1].push_back(vi[i].imag());
            } else {
                vo[0].push_back(0);
                vo[1].push_back(0);
            }
        }
        return vo;
    }
    vfp cvfp_2_vfp(const cvfp& vi, int len, const char* type) {
        vfp vo;
        for(int i = 0; i < len; i++) {
            if(i < vi.size()) {
                vo.push_back((type == "imag") ? vi[i].imag() : vi[i].real());
            } else {
                vo.push_back(0);
            }
        }
        return vo;
    };

    vQfix vfp_2_vQfix(const vfp& vi, int Qlen, int len) {
        vQfix vo;
        for(int i = 0; i < len; i++) {
            if(i < vi.size()) {
                vo.push_back(Qfix((int)(vi[i] * (1 << Qlen)), Qlen));
            } else {
                vo.push_back(Qfix(0, Qlen));
            }
        }
    };
    cvQfix cvfp_2_cvQfix(const cvfp& vi, int Qlen, int len) {
        cvQfix vo;
        for(int i = 0; i < len; i++) {
            if(i < vi.size()) {
                vo.push_back(cQfix(Qfix((int)(vi[i].real() * (1 << Qlen)), Qlen), Qfix((int)(vi[i].imag() * (1 << Qlen)), Qlen)));
            } else {
                vo.push_back(cQfix(Qfix(0, Qlen), Qfix(0, Qlen)));
            }
        }
        return vo;
    }
    cvfp cvQfix_2_cvfp(const cvQfix& vi, int len) {
        cvfp vo;
        // int Qlen = vi[0].real.getQlen();
        // int mask = (1 << Qlen) - 1;
        // for(int i = 0; i < len; i++) {
        //     double realv = ((vi[i].real.getQval() & mask) << 1) - vi[i].real.getQval();
        //     double imagv = ((vi[i].imag.getQval() & mask) << 1) - vi[i].imag.getQval();
        //     realv /= (1 << Qlen);
        //     imagv /= (1 << Qlen);
        //     cnfp value({realv, imagv});
        //     if(i < vi.size()) {
        //         vo.push_back(value);
        //     } else {
        //         vo.push_back(0);
        //     }
        // }
        return vo;
    };
};
