#pragma once

#include <cstdint>
#include <chrono>

struct contact
{
    static const constexpr auto table() { return "contact"; }

    struct id
    {
        static const constexpr auto c_name() { return "id"; }
        int32_t value{0};
    } id;

    struct family_name
    {
        static const constexpr auto c_name() { return "family_name"; }
        static const constexpr auto name() { return "Family Name (Latin script)"; }
        std::string value{};
    } name;

    struct forenames
    {
        static const constexpr auto c_name() { return "forenames"; }
        static const constexpr auto name() { return "Forenames (Latin script)"; }
        std::string value{};
    } forenames;

    struct email
    {
        static const constexpr auto c_name() { return "email"; }
        std::string value{};
    } email;

    struct phone
    {
        static const constexpr auto c_name() { return "phone"; }
        std::string value{};
    } phone;
};
