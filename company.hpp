#pragma once

#include <cstdint>
#include <chrono>

//#include "address_spec.hpp"
//#include "sanctions_spec.hpp"

struct company
{
    static const constexpr auto table() { return "company"; }

    struct id
    {
        static const constexpr auto c_nane() { return "id"; }
        int32_t value{0};
    } id;

    // KYC
    // counteparty information
    // accesible to all users

    struct uuid
    {
        static const constexpr auto c_name() { return "company_unique_identifier"; }
        static const constexpr auto name() { return "Company Unique Identifier"; }
        std::string value{};
    } uuid;

    struct counterparty_name
    {
        static const constexpr auto c_name() { return "counterparty_name"; }
        static const constexpr auto name() { return "Counterparty Name (Latin script)"; }
        std::string value{};
    } counterparty_name;

    struct local_name
    {
        static const constexpr auto c_name() { return "local_name"; }
        static const constexpr auto name() { return "Counterparty Name (Local Characters)"; }
        std::string value{};
    } local_name;

    struct is_branch
    {
        static const constexpr auto c_name() { return "is_branch"; }
        static const constexpr auto name() { return "Is a Branch"; }
        bool value{};
    } is_branch;

//    address_spec address;

    struct websdite
    {
        static const constexpr auto c_name() { return "website"; }
        std::string value{};
    } website;

    // contact person

    struct comercial_registery
    {
        static const constexpr auto c_name() { return "comercial_registery"; }
        static const constexpr auto name() { return "Commercial Registry Number"; }
        std::string value{};
    } comercial_registery;

    struct branch_registery
    {
        static const constexpr auto c_name() { return "branch_registery"; }
        static const constexpr auto name() { return "Branch Commercial Registry Number"; }
        std::string value{};
    } branch_registery;

    struct is_public
    {
        static const constexpr auto c_name() { return "is_public"; }
        static const constexpr auto name() { return "Company Publically Listed"; }
        std::string value{};
    } is_public;

    // foreign key Country
    struct listing_country
    {
        static const constexpr auto c_name() { return "listing_country"; }
        static const constexpr auto name() { return "Country of Main Listing"; }
        std::string value{};
    } listing_country;

    struct lei
    {
        static const constexpr auto c_name() { return "lei"; }
        static const constexpr auto name() { return "Legal Entitiy Identifier (LEI)"; }
        std::string value{};
    } lei;

    // ABC

    // foreign key Individual
    struct pep
    {
        static const constexpr auto c_name() { return "pep"; }
        static const constexpr auto name() { return "Politically Exposed Person (PEP)"; }
        bool value{};
    } pep;

    struct soe
    {
        static const constexpr auto c_name() { return "soe"; }
        static const constexpr auto name() { return "State Owned Enterprise (SOE)"; }
        bool value{};
    } soe;

    // other notable persons linked to

    // regulatory
    // EMIR

    enum categories
    {
        fc,
        fcplus,
        fcminus,
        nfc,
        nfcplus,
        nfcminus,
    };

    // MIFID 2

    struct regulated
    {
        static const constexpr auto c_name() { return "regulated"; }
        bool value{};
    } regulated;

    // regulators --- foreign table
    struct ancellery
    {
        static const constexpr auto c_name() { return "ancellery"; }
        static const constexpr auto name() { return "ANCILLARY status"; }
        bool value{};
    } ancellery;

    // REMIT

    struct acer
    {
        static const constexpr auto c_name() { return "acer"; }
        static const constexpr auto name() { return "ACER Code"; }
        std::string value{};
    } acer;

    // EIC code(s) -- foreign table

    // Dodd Frank
    // DF Categorisation
//    enum df_categories
//    {

//    };

    // sanctions
//    sanctions_spec sanctions;
};
