#pragma once

#include <string>

struct exchange
{
    static const constexpr auto table() { return "exchange"; }

    struct primary_key
    {
        static const constexpr auto c_name() { return "code"; }
        std::string value{};
    } primary_key;

    struct description
    {
        static const constexpr auto c_name() { return "description"; }
        std::string value{};
    } description;
};
