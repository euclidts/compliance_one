#pragma once

#include <cstdint>

struct regulator
{
    static consteval auto table() { return "regulator"; }
    static consteval auto primary_key() { return &regulator::id; }

    struct id
    {
        static const constexpr auto c_name() { return "id"; }
        int32_t value;
    } id;

    struct name
    {
        static const constexpr auto c_name() { return "name"; }
        std::string value;
    } name;

    struct website
    {
        static const constexpr auto c_name() { return "website"; }
        std::string value;
    } website;
};
