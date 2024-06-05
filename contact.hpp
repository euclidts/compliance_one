#pragma once

#include <cstdint>

struct contact
{
    static consteval auto table() { return "contact"; }
    static consteval auto primary_key() { return &contact::id; }

    struct id
    {
        static consteval auto c_name() { return "id"; }
        int32_t value;
    } id;

    struct family_name
    {
        static consteval auto c_name() { return "family_name"; }
        // static consteval auto name() { return "Family Name (Latin script)"; }
        std::string value;
    } family_name;

    struct forenames
    {
        static consteval auto c_name() { return "forenames"; }
        // static consteval auto name() { return "Forenames (Latin script)"; }
        std::string value;
    } forenames;

    struct email
    {
        static consteval auto c_name() { return "email"; }
        std::string value;
    } email;

    struct calling_code
    {
        static consteval auto c_name() { return "calling_code"; }
        // static consteval auto max() { return 5; }
        std::string value;
    } calling_code;

    struct phone
    {
        static consteval auto c_name() { return "phone"; }
        // static consteval auto max() { return 13; }
        std::string value;
    } phone;
};
