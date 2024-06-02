#pragma once

#include <tuple>

#include "country.hpp"
#include "regulator.hpp"

struct jurisdiction
{
    static consteval auto table() { return "jurisdiction"; }
    static consteval auto primary_key()
    { return std::make_tuple(&jurisdiction::regulator_id, &jurisdiction::country_id); }

    struct regulator_id
    {
        static const constexpr auto c_name() { return "regulator_id"; }
        int32_t value;
        static const constexpr auto foreign_key() { return &regulator::id; }
    } regulator_id;


    struct country_id
    {
        static const constexpr auto c_name() { return "country_id"; }
        uint32_t value;
        static const constexpr auto foreign_key() { return &country::id; }
    } country_id;
};
