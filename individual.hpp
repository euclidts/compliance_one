#pragma once

#include <chrono>

#include "contact.hpp"
#include "address.hpp"

struct individual
{
    static consteval auto table() { return "individual"; }
    static consteval auto primary_key() { return &individual::id; }

    struct id
    {
        static consteval auto c_name() { return "id"; }
        int32_t value;
    } id;

    struct contact_id
    {
        static consteval auto c_name() { return "contact_id"; }
        int32_t value;
        // static consteval auto property() { return "unique"; }
        static consteval auto references() { return &contact::id; }
    } contact_id;

    // KYC 
    // counteparty information
    // accesible to all users

    struct local_name
    {
        // static consteval auto name() { return "Name (Local Characters)"; }
        static consteval auto c_name() { return "local_name"; }
        std::string value;
    } local_name;

    struct local_forenames
    {
        // static consteval auto name() { return "Forenames (Local Characters)"; }
        static consteval auto c_name() { return "local_forenames"; }
        std::string value;
    } local_forenames;

    struct date_of_birth
   {
        // static consteval auto name() { return "Date of birth"; }
        static consteval auto c_name() { return "date_of_birth"; }
        std::chrono::sys_days value;
   } date_of_birth;

    struct passport
    {
        // static consteval auto name() { return "Passport number"; }
        static consteval auto c_name() { return "passport"; }
        std::string value;
    } passport;

    struct expiry_date
    {
        // static consteval auto name() { return "Expiry date"; }
        static consteval auto c_name() { return "expiry_date"; }
        std::chrono::sys_days value;
    } expiry_date;

    struct issuing
    {
        // static consteval auto name() { return "Issuing country"; }
        static consteval auto c_name() { return "issuing"; }
        uint32_t value;
        static consteval auto references() { return &country::id; }
    } issuing;

    struct pep
    {
        // static consteval auto name() { return "Is a PEP"; }
        static consteval auto c_name() { return "pep"; }
        bool value;
    } pep;

    struct pep_country
    {
        // static consteval auto name() { return "PEP Country"; }
        static consteval auto c_name() { return "pep_country"; }
        uint32_t value;
        static consteval auto references() { return &country::id; }
    } pep_country;

    struct pep_notes
    {
        static consteval auto c_name() { return "pep_notes"; }
        // static consteval auto name() { return "Additional Notes"; }
        std::string value;
    } pep_notes;

    // only accesible to compliance users
    struct notes
    {
        static consteval auto c_name() { return "notes"; }
        std::string value;
    } notes;

    struct address_id
    {
        static consteval auto c_name() { return "address_id"; }
        int32_t value;
        static consteval auto references() { return &address::id; }
    } address_id;
};
