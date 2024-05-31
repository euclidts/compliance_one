#pragma once

#include <cstdint>
#include <string>

struct company_group
{
    static const constexpr auto table() { return "company_group"; }
    static const constexpr auto primary_key() { return &company_group::id; }

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
