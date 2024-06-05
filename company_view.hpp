#pragma once

#include "company.hpp"

struct company_view
{
    static consteval auto table() { return "company_view"; }
    // static consteval auto view() { return "company_ivew"; }
    static consteval auto primary_key() { return &company_view::id; }

    struct id
    {
        static consteval auto c_name() { return "id"; }
        int32_t value;
        static consteval auto references() { return &company::id; }
    } id;

    struct name
    {
        static consteval auto c_name() { return "name"; }
        std::string value;
        static consteval auto references() { return &company::name; }
    } name;

    struct local_name
    {
        static consteval auto c_name() { return "local_name"; }
        std::string value;
        static consteval auto references() { return &company::local_name; }
    } local_name;

    struct contact_id
    {
        static consteval auto c_name() { return "contact_id"; }
        int32_t value;
        // static consteval auto property() { return "unique"; }
        static consteval auto references() { return &company::contact_id; }
    } contact_id;

    struct address_id
    {
        static consteval auto c_name() { return "address_id"; }
        int32_t value;
        static consteval auto references() { return &company::address_id; }
    } address_id;

    // struct country_name
    // {
    //     static consteval auto c_name() { return "country_name"; }
    //     std::string value;
    //     static consteval auto references() { return std::make_tuple(&company::address_id, &address::country_id, &country::name); }
    // } country_name;
};
