#pragma once

#include "individual.hpp"

struct individual_view
{
    static consteval auto table() { return "individual_view"; }
    // static consteval auto view() { return "individual_ivew"; }
    static consteval auto primary_key() { return &individual_view::id; }

    struct id
    {
        static consteval auto c_name() { return "id"; }
        int32_t value;
        static consteval auto references() { return &individual::id; }
    } id;

    struct pep
    {
        static consteval auto c_name() { return "pep"; }
        bool value;
        static consteval auto references() { return &individual::pep; }
    } pep;

    struct local_name
    {
        static consteval auto c_name() { return "local_name"; }
        std::string value;
        static consteval auto references() { return &individual::local_name; }
    } local_name;

    struct local_forenames
    {
        static consteval auto c_name() { return "local_forenames"; }
        std::string value;
        static consteval auto references() { return &individual::local_forenames; }
    } local_forenames;

    struct contact_id
    {
        static consteval auto c_name() { return "contact_id"; }
        int32_t value;
        // static consteval auto property() { return "unique"; }
        static consteval auto references() { return &individual::contact_id; }
    } contact_id;

    struct family_name
    {
        static consteval auto c_name() { return "family_name"; }
        std::string value;
        static consteval auto references() { return std::make_tuple(&individual::contact_id, &contact::family_name); }
    } family_name;

    struct forenames
    {
        static consteval auto c_name() { return "forenames"; }
        std::string value;
        static consteval auto references() { return std::make_tuple(&individual::contact_id, &contact::forenames); }
    } forenames;

    struct address_id
    {
        static consteval auto c_name() { return "address_id"; }
        int32_t value;
        static consteval auto references() { return &individual::address_id; }
    } address_id;

    // struct country_name
    // {
    //     static consteval auto c_name() { return "country_name"; }
    //     std::string value;
    //     static consteval auto references() { return std::make_tuple(&individual::address_id, &address::country_id, &country::name); }
    // } country_name;
};
