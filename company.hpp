#pragma once

#include <cstdint>
#include <chrono>

#include "address.hpp"
#include "contact.hpp"

struct company
{
    static const constexpr auto table() { return "company"; }
    static const constexpr auto primary_key() { return &company::id; }

    struct id
    {
        static const constexpr auto c_name() { return "id"; }
        int32_t value{0};
    } id;

    // KYC
    // counteparty information
    // accesible to all users

    struct uuid
    {
        static const constexpr auto c_name() { return "uuid"; }
        // static const constexpr auto name() { return "Company Unique Identifier"; }
        std::string value{};
    } uuid;

    struct name
    {
        static const constexpr auto c_name() { return "name"; }
        // static const constexpr auto name() { return "Counterparty Name (Latin script)"; }
        std::string value{};
    } name;

    struct local_name
    {
        static const constexpr auto c_name() { return "local_name"; }
        // static const constexpr auto name() { return "Counterparty Name (Local Characters)"; }
        std::string value{};
    } local_name;

    struct is_branch
    {
        static const constexpr auto c_name() { return "is_branch"; }
        // static const constexpr auto name() { return "Is a Branch"; }
        bool value{};
    } is_branch;

    struct address_id
    {
        static const constexpr auto c_name() { return "address_id"; }
        int32_t value{0};
        static const constexpr auto references() { return &address::id; }
    } address_id;

    struct branch_address_id
    {
        static const constexpr auto c_name() { return "branch_address_id"; }
        int32_t value{0};
        static const constexpr auto references() { return &address::id; }
    } branch_address_id;

    struct website
    {
        static const constexpr auto c_name() { return "website"; }
        std::string value{};
    } website;

    struct contact_id
    {
        static const constexpr auto c_name() { return "contact_id"; }
        int32_t value{0};
        static const constexpr auto references() { return &contact::id; }
    } contact_id;

    struct is_public
    {
        static const constexpr auto c_name() { return "is_public"; }
        // static const constexpr auto name() { return "Company Publically Listed"; }
        bool value{};
    } is_public;

    struct comercial_registery
    {
        static const constexpr auto c_name() { return "comercial_registery"; }
        // static const constexpr auto name() { return "Commercial Registry Number"; }
        std::string value{};
    } comercial_registery;

    struct branch_registery
    {
        static const constexpr auto c_name() { return "branch_registery"; }
        // static const constexpr auto name() { return "Branch Commercial Registry Number"; }
        std::string value{};
    } branch_registery;

    // foreign key Country
    struct listing_country_id
    {
        static const constexpr auto c_name() { return "listing_country_id"; }
        // static const constexpr auto name() { return "Country of Main Listing"; }
        uint32_t value{0};
        static const constexpr auto references() { return &country::id; }
    } listing_country_id;

    struct lei
    {
        static const constexpr auto c_name() { return "lei"; }
        // static const constexpr auto name() { return "Legal Entitiy Identifier (LEI)"; }
        std::string value{};
    } lei;

    // ABC
    struct pep
    {
        static const constexpr auto c_name() { return "pep"; }
        // static const constexpr auto name() { return "Associated PEPs"; }
        bool value{};
    } pep;

    struct soe
    {
        static const constexpr auto c_name() { return "soe"; }
        // static const constexpr auto name() { return "State Owned Enterprise (SOE)"; }
        bool value{};
    } soe;

    // other notable persons linked to

    // regulatory
    // EMIR

    // enum categories
    // {
    //     fc,
    //     fcplus,
    //     fcminus,
    //     nfc,
    //     nfcplus,
    //     nfcminus,
    // };

    // MIFID 2

    struct regulated
    {
        static const constexpr auto c_name() { return "regulated"; }
        bool value{};
    } regulated;

    // regulators --- foreign table
    struct ancillary
    {
        static const constexpr auto c_name() { return "ancillary"; }
        // static const constexpr auto name() { return "ANCILLARY status"; }
        bool value{};
    } ancillary;

    // REMIT

    struct acer
    {
        static const constexpr auto c_name() { return "acer"; }
        // static const constexpr auto name() { return "ACER Code"; }
        std::string value{};
    } acer;

    struct exchange
    {
        static const constexpr auto c_name() { return "exchange"; }
        std::string value{};
    } exchange;

    // EIC code(s) -- foreign table

    // Dodd Frank
    // DF Categorisation
//    enum df_categories
//    {

//    };

    // sanctions
};
