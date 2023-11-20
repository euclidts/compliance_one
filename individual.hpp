#pragma once

#include "contact.hpp"
//#include <address_spec.hpp>

struct individual
{
    static const constexpr auto table() { return "individual"; }

    struct id
    {
        static const constexpr auto c_name() { return "id"; }
        int32_t value{0};
    } id;

    struct contact_id
    {
        static const constexpr auto c_name() { return "contact_id"; }
        int32_t value{0};
        static const constexpr auto property() { return "unique"; }
        static const constexpr auto references() { return &contact::id; }
    } contact_id;
    
    enum roles
    {
        owner,
        director,
        intermediary,
        other
    };

    struct role
    {
        static const constexpr auto c_name() { return "role"; }
        roles value{other};
    } role;

    // KYC 
    // counteparty information
    // accesible to all users

    struct uuid
    {
        static const constexpr auto c_name() { return "individual_unique_identifier"; }
        static const constexpr auto name() { return "Individual Unique Identifier"; }
        std::string value{};
    } uuid;

    struct local_name
    {
        static const constexpr auto c_name() { return "local_name"; }
        static const constexpr auto name() { return "Name (Local Characters)"; }
        std::string value{};
    } local_name;

    struct local_forenames
    {
        static const constexpr auto c_name() { return "local_forenames"; }
        static const constexpr auto name() { return "Forenames (Local Characters)"; }
        std::string value{};
    } local_forenames;

//    address_spec address;

//    struct date_of_birth
//    {
//        static const constexpr auto c_name() { return "date_of_birth"; }
//        static const constexpr auto name() { return "Date of Birth"; }
//        std::chrono::year_month_day value{};
//    } date_of_birth;

    struct pep
    {
        static const constexpr auto c_name() { return "pep"; }
        static const constexpr auto name() { return "Is a PEP"; }
        bool value{};
    } pep;

    struct pep_country
    {
        static const constexpr auto c_name() { return "pep_country"; }
        static const constexpr auto name() { return "Country"; }
        bool value{};
    } pep_country;

    struct pep_notes
    {
        static const constexpr auto c_name() { return "pep_notes"; }
        static const constexpr auto name() { return "Additional Notes"; }
        std::string value{};
    } pep_notes;

    // only accesible to compliance users
    struct notes
    {
        static const constexpr auto c_name() { return "notes"; }
        std::string value{};
    } notes;
};
