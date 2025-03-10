//
// Created by lenovo on 08.02.2025.
//

#ifndef REFACTORINGLAB1_PCBCLASS_H
#define REFACTORINGLAB1_PCBCLASS_H

#include "iostream"

using namespace std;

class PCBClass {
public:
    string type;
    string lterm;
    string dbdname;
    string name;
    string procopt;
    string altresp;
    string sametrm;
    string sb;
    string keylen;
    string procseq;
    string view;
    string pos;
    string modify;
    string express;
    string pcbname;
    string list;

    PCBClass();
    PCBClass(const string& jsonFile);
    void printInfo();
    void writeJSON(const string& jsonFile);
};


#endif //REFACTORINGLAB1_PCBCLASS_H
