//
// Created by lenovo on 08.02.2025.
//

#include "PCBClass.h"
#include <fstream>
#include <iostream>
#include "json.hpp"

using json = nlohmann::json;

void PCBClass::printInfo() {
    cout << "PCB information:" << endl;
    cout << "Type: " << type << endl;
    cout << "Lterm: " << lterm << endl;
    cout << "DBD name: " << dbdname << endl;
    cout << "Name: " << name << endl;
    cout << "Procopt: " << procopt << endl;
    cout << "Altresp: " << altresp << endl;
    cout << "Sametrm: " << sametrm << endl;
    cout << "SB: " << sb << endl;
    cout << "Keylen: " << keylen << endl;
    cout << "Procseq: " << procseq << endl;
    cout << "View: " << view << endl;
    cout << "Pos: " << pos << endl;
    cout << "Modify: " << modify << endl;
    cout << "Express: " << express << endl;
    cout << "PCB name: " << pcbname << endl;
    cout << "List: " << list << endl;
}


void PCBClass::writeJSON(const string& jsonFile) {
    json j = {
            {"type",    type},
            {"lterm",   lterm},
            {"dbdname", dbdname},
            {"name",    name},
            {"procopt", procopt},
            {"altresp", altresp},
            {"sametrm", sametrm},
            {"sb",      sb},
            {"keylen",  keylen},
            {"procseq", procseq},
            {"view",    view},
            {"pos",     pos},
            {"modify",  modify},
            {"express", express},
            {"pcbname", pcbname},
            {"list",    list}
    };

    ofstream file(jsonFile);
    if (!file) {
        cerr << "Error: Unable to open file for writing!" << endl;
        return;
    }

    file << j.dump(4);
    file.close();
}

PCBClass::PCBClass() = default;

PCBClass::PCBClass(const string& jsonFile) {
    ifstream file(jsonFile);
    if (!file.is_open()) {
        throw runtime_error("Unable to open JSON file");
    }
    json j;
    file >> j;
    file.close();

    j.at("type").get_to(type);
    j.at("lterm").get_to(lterm);
    j.at("dbdname").get_to(dbdname);
    j.at("name").get_to(name);
    j.at("procopt").get_to(procopt);
    j.at("altresp").get_to(altresp);
    j.at("sametrm").get_to(sametrm);
    j.at("sb").get_to(sb);
    j.at("keylen").get_to(keylen);
    j.at("procseq").get_to(procseq);
    j.at("view").get_to(view);
    j.at("pos").get_to(pos);
    j.at("modify").get_to(modify);
    j.at("express").get_to(express);
    j.at("pcbname").get_to(pcbname);
    j.at("list").get_to(list);
}