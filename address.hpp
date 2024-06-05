#pragma once

#include "country.hpp"

struct address
{
    static consteval auto table() { return "address"; }
    static consteval auto primary_key() { return &address::id; }

    struct id
    {
        static consteval auto c_name() { return "id"; }
        int32_t value;
    } id;

    struct country_id
    {
        // static consteval auto name() { return "Country"; }
        static consteval auto c_name() { return "country_id"; }
        uint32_t value;
        static consteval auto references() { return &country::id; }
    } country_id;

    struct address_lines
    {
        // static consteval auto name() { return "Address lines"; }
        static consteval auto c_name() { return "address_lines"; }
        std::string value;
    } address_lines;

    struct locality
    {
        static consteval auto c_name() { return "locality"; }
        std::string value;
    } locality;

    struct region
    {
        static consteval auto c_name() { return "region"; }
        std::string value;
    } region;

    struct postcode
    {
        static consteval auto c_name() { return "postcode"; }
        std::string value;
    } postcode;
};
