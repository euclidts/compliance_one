#pragma once

#include <cstdint>
#include <string>

struct exchange
{
    static consteval auto table() { return "exchange"; }
    static consteval auto primary_key() { return &exchange::id; }

    struct id
    {
        static consteval auto c_name() { return "id"; }
        uint32_t value;
    } id;

    struct code
    {
        static consteval auto c_name() { return "code"; }
        std::string value;
    } code;

    struct description
    {
        static consteval auto c_name() { return "description"; }
        std::string value;
    } description;
};
