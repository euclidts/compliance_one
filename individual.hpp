#pragma once

#include <chrono>

#include "contact.hpp"
#include "address.hpp"

struct individual
{
    static const constexpr auto table() { return "individual"; }

    struct primary_key
    {
        static const constexpr auto c_name() { return "id"; }
        int32_t value{0};
    } primary_key;

    struct contact_id
    {
        static const constexpr auto c_name() { return "contact_id"; }
        int32_t value{0};
        static const constexpr auto property() { return "unique"; }
        static const constexpr auto references() { return &contact::primary_key; }
    } contact_id;

    // KYC 
    // counteparty information
    // accesible to all users

    struct local_name
    {
        static const constexpr auto name() { return "Name (Local Characters)"; }
        static const constexpr auto c_name() { return "local_name"; }
        std::string value{};
    } local_name;

    struct local_forenames
    {
        static const constexpr auto name() { return "Forenames (Local Characters)"; }
        static const constexpr auto c_name() { return "local_forenames"; }
        std::string value{};
    } local_forenames;

    struct date_of_birth
   {
        static const constexpr auto name() { return "Date of birth"; }
        static const constexpr auto c_name() { return "date_of_birth"; }
        std::chrono::sys_days value{};
   } date_of_birth;

    struct passport
    {
        static const constexpr auto name() { return "Passport number"; }
        static const constexpr auto c_name() { return "passport"; }
        std::string value{};
    } passport;

    struct expeiry_date
    {
        static const constexpr auto name() { return "Expeiry date"; }
        static const constexpr auto c_name() { return "expeiry_date"; }
        std::chrono::sys_days value{};
    } expeiry_date;

    struct issuing
    {
        static const constexpr auto name() { return "Issuing country"; }
        static const constexpr auto c_name() { return "issuing"; }
        uint32_t value{0};
        static const constexpr auto references() { return &country::primary_key; }
    } issuing;

    struct pep
    {
        static const constexpr auto name() { return "Is a PEP"; }
        static const constexpr auto c_name() { return "pep"; }
        bool value{};
    } pep;

    struct pep_country
    {
        static const constexpr auto name() { return "PEP Country"; }
        static const constexpr auto c_name() { return "pep_country"; }
        uint32_t value{0};
        static const constexpr auto references() { return &country::primary_key; }
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

    struct address_id
    {
        static const constexpr auto c_name() { return "address_id"; }
        int32_t value{0};
        static const constexpr auto references() { return &address::primary_key; }
    } address_id;
};
