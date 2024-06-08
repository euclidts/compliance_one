#pragma once

#include <cstdint>
#include "region.hpp"

struct regulator
{
    static consteval auto table() { return "regulator"; }
    static consteval auto primary_key() { return &regulator::id; }

    struct id
    {
        static consteval auto c_name() { return "id"; }
        int32_t value;
    } id;

    struct name
    {
        static consteval auto c_name() { return "name"; }
        std::string value;
    } name;

    struct region_id
    {
        static consteval auto c_name() { return "region_id"; }
        uint32_t value;
        static consteval auto foreign_key() { return &region::id; }
    } region_id;

    struct website
    {
        static consteval auto c_name() { return "website"; }
        std::string value;
    } website;
};
