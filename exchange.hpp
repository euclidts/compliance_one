#pragma once

#include <string>

struct exchange
{
    static const constexpr auto table() { return "exchange"; }
    static const constexpr auto primary_key() { return &exchange::id; }

    struct id
    {
        static const constexpr auto c_name() { return "code"; }
        std::string value{};
    } id;

    struct description
    {
        static const constexpr auto c_name() { return "description"; }
        std::string value{};
    } description;
};
