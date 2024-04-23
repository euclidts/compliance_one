#pragma once

#include <cstdint>
#include <string>

struct ctp_group
{
    static const constexpr auto table() { return "ctp_group"; }
    static const constexpr auto primary_key() { return &ctp_group::id; }

    struct id
    {
        static const constexpr auto c_name() { return "id"; }
        int32_t value{0};
    } id;

    struct group_name
    {
        static const constexpr auto c_name() { return "name"; }
        std::string value{};
    } group_name;
};
