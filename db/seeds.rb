require './db/scripts/seed'
# PHASE 1
# DATABASE IS CLEARED

# Tix::Seed.clear_data

# PHASE 2
# THIS SCRIPT SEEDS ARTISTS, CUSTOMERS, EVENTS

# Tix::Seed.seed_data
# Tix::Seed.seed_events

# PHASE 3
# ASSOCIATIONS AND SUPPORTING FIELDS

Tix::Seed.fetch_artist_images
# Tix::Seed.assign_artists_to_events

# PHASE 4
# CAN OPTIONALLY GENERATE TEST ORDER DATA

# Tix::Seed.generate_data
