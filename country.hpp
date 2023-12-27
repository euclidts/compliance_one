#pragma once

#include <chrono>

#include "user.hpp"

struct country
{
    static const constexpr int permission(const user* u)
    {
        if (u) return user::read;
        else return user::read + user::write;
    }

    static const constexpr auto table() { return "country"; }

    struct primary_key
    {
        static const constexpr auto c_name() { return "id"; }
        uint32_t value{0};
    } primary_key;

    struct name
    {
        static const constexpr auto c_name() { return "name"; }
        std::string value{};
    } name;

    // struct official_state_name
    // {
    //     static const constexpr auto c_name() { return "official_state_name"; }
    //     static const constexpr auto name() { return "Official state name"; }
    //     std::string value{};
    // } official_state_name;

    struct iso3
    {
        static const constexpr auto name() { return "ISO 3"; }
        static const constexpr auto c_name() { return "iso3"; }
        std::string value{};
    } iso3;

    struct numeric_code
    {
        static const constexpr auto name() { return "Numeric code"; }
        static const constexpr auto c_name() { return "numeric_code"; }
        std::string value{};
    } numeric_code;

    struct phonecode
    {
        static const constexpr auto name() { return "Calling code"; }
        static const constexpr auto c_name() { return "phonecode"; }
        std::string value{};
    } phonecode;

    struct latitude
    {
        static const constexpr auto c_name() { return "latitude"; }
        double value{};
    } latitude;

    struct longitude
    {
        static const constexpr auto c_name() { return "longitude"; }
        double value{};
    } longitude;

    struct emoji
    {
        static const constexpr auto name() { return "Flag"; }
        static const constexpr auto c_name() { return "emoji"; }
        std::string value{};
    } emoji;

    struct wikiDataId
    {
        static const constexpr auto c_name() { return "wikiDataId"; }
        std::string value{};
    } wikiDataId;

    enum ranks
    {
        low,
        mid,
        high
    };

    struct ranking
    {
        static const constexpr auto c_name() { return "ranking"; }
        static const constexpr auto name() { return "Internal Ranking"; }
        ranks value{mid};
    } ranking;

    struct fatf
    {
        static const constexpr auto c_name() { return "fatf"; }
        static const constexpr auto name() { return "FATF"; }
        ranks value{mid};
    } fatf;

    struct transparency
    {
        static const constexpr auto c_name() { return "transparency"; }
        static const constexpr auto name() { return "Transparency International"; }
        uint8_t value{5};
    } transparency;

    struct world_bank
    {
        static const constexpr auto c_name() { return "world_bank"; }
        static const constexpr auto name() { return "World Bank"; }
        uint8_t value{5};
    } world_bank;

    struct sovereignty_id
    {
        static const constexpr auto c_name() { return "sovereignty_id"; }
        static const constexpr auto name() { return "Sovereignty"; }
        uint32_t value{0};
        static const constexpr auto foreign_key() { return &country::primary_key; }
    } sovereignty_id;

    // phone extension
};
