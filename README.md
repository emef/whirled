Whirled
=======

* whirled app (supervisor)
  - world ets table
  - building ets table
  - character ets table
  - game (supervised)
    * world (supervised, use ets table)
      - bounds
      - path graph
      - next_valid_location(current, destination)
      - distance_to(current, destination)
    * building registry (supervised, use ets table)
      - map buildId -> building
      - get_by_purpose(purpose)
    * building (supervised)
      - identifier (buildId)
      - capacity
      - location
      - dimensions
      - purpose
      - owner -> charId
  - character registry (supervised)
    * map charId -> character
  - characters (genserver)
    * identifier (charId)
    * name/description/etc.
    * location
    * containingBuilding -> buildId
    * aspiration graph
      - top-level aspiration and DAG of goals to get there
    * mindset (current goal)
      - what is being focused on currently
    * intention
      - immediate next step towards current goal
