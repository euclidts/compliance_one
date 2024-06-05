#pragma once

#include <cstdint>
#include <string>

struct company_group
{
    static consteval auto table() { return "company_group"; }
    static consteval auto primary_key() { return &company_group::id; }

    struct id
    {
        static consteval auto c_name() { return "id"; }
        int32_t value;
    } id;

    struct group_name
    {
        static consteval auto c_name() { return "name"; }
        std::string value;
    } group_name;
};
