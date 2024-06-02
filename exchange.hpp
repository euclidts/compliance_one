#pragma once

#include <string>

struct exchange
{
    static consteval auto table() { return "exchange"; }
    static consteval auto primary_key() { return &exchange::id; }

    struct id
    {
        static const constexpr auto c_name() { return "code"; }
        std::string value;
    } id;

    struct description
    {
        static const constexpr auto c_name() { return "description"; }
        std::string value;
    } description;
};
