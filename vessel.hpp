#pragma once

#include <cstdint>
#include <string>

#include "company.hpp"

struct vessel
{
    static const constexpr auto table() { return "vessel"; }

    struct primary_key
    {
        static const constexpr auto c_name() { return "id"; }
        int32_t value{0};
    } primary_key;

    // KYC 
    // Vessel information
    // accesible to all users

    struct imo
    {
        static const constexpr auto c_name() { return "imo"; }
        // static const constexpr auto name() { return "IMO"; }
        std::string value{};
    } imo;

    struct vessel_name
    {
        static const constexpr auto c_name() { return "name"; }
        std::string value{};
    } vessel_name;

    struct owner
    {
        static const constexpr auto c_name() { return "owner"; }
        int32_t value{};
        static const constexpr auto references() { return &company::primary_key; }
    } owner;

    struct manager
    {
        static const constexpr auto c_name() { return "manager"; }
        int32_t value{};
        static const constexpr auto references() { return &company::primary_key; }
    } manager;

    // restrictions Flag
};
