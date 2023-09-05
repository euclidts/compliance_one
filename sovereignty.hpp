#pragma once

#include <cstdint>
#include <string>

struct sovereignty
{
    static const constexpr auto table() { return "sovereignty"; }
    static const constexpr auto primary_key() { return &sovereignty::id; }

    struct id
    {
        static const constexpr auto c_name() { return "id"; }
        int32_t value{0};
    } id;

    struct name
    {
        static const constexpr auto c_name() { return "name"; }
        std::string value{};
    } name;

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
        int8_t value{5};
    } transparency;

    struct world_bank
    {
        static const constexpr auto c_name() { return "world_bank"; }
        static const constexpr auto name() { return "World Bank"; }
        int8_t value{5};
    } world_bank;
};
