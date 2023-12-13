#pragma once

#include <chrono>

#include "contact.hpp"

// using namespace std::chrono;

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
    
    // enum roles
    // {
    //     owner,
    //     director,
    //     intermediary,
    //     other
    // };

    // struct role
    // {
    //     static const constexpr auto c_name() { return "role"; }
    //     roles value{other};
    // } role;

    // KYC 
    // counteparty information
    // accesible to all users

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

    struct country
    {
        static const constexpr auto c_name() { return "country"; }
        int32_t value{0};
        static const constexpr auto references() { return &country::id; }
    } country;

    struct address
    {
        static const constexpr auto c_name() { return "address"; }
        std::string value{};
    } address;

    struct locality
    {
        static const constexpr auto c_name() { return "locality"; }
        std::string value{};
    } locality;

    struct region
    {
        static const constexpr auto c_name() { return "region"; }
        std::string value{};
    } region;

    struct postcode
    {
        static const constexpr auto c_name() { return "postcode"; }
        std::string value{};
    } postcode;

   struct date_of_birth
   {
        static const constexpr auto c_name() { return "date_of_birth"; }
        static const constexpr auto name() { return "Date of birth"; }
        std::chrono::year_month_day value{};
        // year_month_day value{floor<days>(system_clock::now())};
   } date_of_birth;

    // passport number
    // expeiry date
    // ensuing country
    // struct uuid
    // {
    //     static const constexpr auto c_name() { return "individual_unique_identifier"; }
    //     static const constexpr auto name() { return "Individual Unique Identifier"; }
    //     std::string value{};
    // } uuid;

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

    //
};
