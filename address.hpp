#pragma once

#include "country.hpp"

struct address
{
    static const constexpr auto table() { return "address"; }
    static const constexpr auto primary_key() { return &address::id; }

    struct id
    {
        static const constexpr auto c_name() { return "id"; }
        int32_t value{0};
    } id;

    struct country_id
    {
        // static const constexpr auto name() { return "Country"; }
        static const constexpr auto c_name() { return "country_id"; }
        uint32_t value{0};
        static const constexpr auto references() { return &country::id; }
    } country_id;

    struct address_lines
    {
        // static const constexpr auto name() { return "Address lines"; }
        static const constexpr auto c_name() { return "address_lines"; }
        std::string value{};
    } address_lines;

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
};
