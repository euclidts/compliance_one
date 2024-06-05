#pragma once

#include <cstdint>
#include <string>

#include "company.hpp"

struct vessel
{
    static consteval auto table() { return "vessel"; }
    static consteval auto primary_key() { return &vessel::id; }

    struct id
    {
        static consteval auto c_name() { return "id"; }
        int32_t value;
    } id;

    // KYC 
    // Vessel information
    // accesible to all users

    struct vessel_name
    {
        static consteval auto c_name() { return "name"; }
        std::string value;
    } vessel_name;

    struct imo
    {
        static consteval auto c_name() { return "imo"; }
        // static consteval auto name() { return "IMO"; }
        std::string value;
    } imo;

    struct owner_id
    {
        static consteval auto c_name() { return "owner_id"; }
        int32_t value;
        static consteval auto references() { return &company::id; }
    } owner_id;

    struct manager_id
    {
        static consteval auto c_name() { return "manager_id"; }
        int32_t value;
        static consteval auto references() { return &company::id; }
    } manager_id;

    // restrictions Flag
};
