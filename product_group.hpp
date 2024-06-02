#pragma once

#include <cstdint>
#include <string>

struct product_group
{
    static consteval auto table() { return "product_group"; }
    static consteval auto primary_key() { return &product_group::id; }

    struct id
    {
        static const constexpr auto c_name() { return "id"; }
        int32_t value;
    } id;

    struct group_name
    {
        static const constexpr auto c_name() { return "name"; }
        std::string value;
    } group_name;
};
