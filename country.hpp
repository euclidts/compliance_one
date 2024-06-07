#pragma once

#include <chrono>

#include "region.hpp"

struct country
{
    // static consteval int permission(const user* u)
    // {
    //     if (u) return user::read;
    //     else return user::read + user::write;
    // }

    static consteval auto table() { return "country"; }
    static consteval auto primary_key() { return &country::id; }

    struct id
    {
        static consteval auto c_name() { return "id"; }
        uint32_t value;
    } id;

    struct name
    {
        static consteval auto c_name() { return "name"; }
        std::string value;
    } name;

    // struct official_state_name
    // {
    //     static consteval auto c_name() { return "official_state_name"; }
    //     static consteval auto name() { return "Official state name"; }
    //     std::string value;
    // } official_state_name;

    struct iso3
    {
        // static consteval auto name() { return "ISO 3"; }
        static consteval auto c_name() { return "iso3"; }
        std::string value;
    } iso3;

    struct numeric_code
    {
        // static consteval auto name() { return "Numeric code"; }
        static consteval auto c_name() { return "numeric_code"; }
        std::string value;
    } numeric_code;

    struct phonecode
    {
        static consteval auto name() { return "Calling code"; }
        static consteval auto c_name() { return "phonecode"; }
        std::string value;
    } phonecode;

    struct region_id
    {
        static consteval auto c_name() { return "region_id"; }
        uint32_t value;
        static consteval auto foreign_key() { return &region::id; }
    } region_id;

    struct latitude
    {
        static consteval auto c_name() { return "latitude"; }
        double value;
    } latitude;

    struct longitude
    {
        static consteval auto c_name() { return "longitude"; }
        double value;
    } longitude;

    struct emoji
    {
        static consteval auto name() { return "Flag"; }
        static consteval auto c_name() { return "emoji"; }
        std::string value;
    } emoji;

    struct wikiDataId
    {
        static consteval auto c_name() { return "wikiDataId"; }
        std::string value;
    } wikiDataId;

    enum ranks
    {
        low,
        mid,
        high
    };

    struct ranking
    {
        static consteval auto c_name() { return "ranking"; }
        // static consteval auto name() { return "Internal Ranking"; }
        ranks value;
    } ranking;

    struct fatf
    {
        static consteval auto c_name() { return "fatf"; }
        // static consteval auto name() { return "FATF"; }
        ranks value;
    } fatf;

    struct transparency
    {
        static consteval auto c_name() { return "transparency"; }
        // static consteval auto name() { return "Transparency International"; }
        uint8_t value;
    } transparency;

    struct world_bank
    {
        static consteval auto c_name() { return "world_bank"; }
        // static consteval auto name() { return "World Bank"; }
        uint8_t value;
    } world_bank;

    struct sovereignty_id
    {
        static consteval auto c_name() { return "sovereignty_id"; }
        // static consteval auto name() { return "Sovereignty"; }
        uint32_t value;
        static consteval auto foreign_key() { return &country::id; }
    } sovereignty_id;

    // phone extension
};
