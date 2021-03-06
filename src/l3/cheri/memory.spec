--------------------------------------------------------------------------------
-- CHERI default memory
-- (c) Alexandre Joannou, University of Cambridge
--------------------------------------------------------------------------------

-----------------
-- Memory type --
-----------------

construct DataType {Cap :: Capability, Raw :: CAPRAWBITS}

-----------------
-- stats utils --
-----------------

record MemStats
{
    data_reads  :: nat
    data_writes :: nat
    inst_reads  :: nat
    valid_cap_reads     :: nat
    invalid_cap_reads   :: nat
    valid_cap_writes    :: nat
    invalid_cap_writes  :: nat
    working_set         :: nat
    mem_4K_touched      :: nat
    tags_now_set        :: nat
    tags_ever_set       :: nat
    tags_4K_now_set     :: nat
    tags_4K_ever_set    :: nat
    tags_16K_now_set    :: nat
    tags_16K_ever_set   :: nat
}

MemStats nullMemStats =
{
    var stats;
    stats.data_reads  <- 0;
    stats.data_writes <- 0;
    stats.inst_reads  <- 0;
    stats.valid_cap_reads       <- 0;
    stats.invalid_cap_reads     <- 0;
    stats.valid_cap_writes      <- 0;
    stats.invalid_cap_writes    <- 0;
    stats.working_set           <- 0;
    stats.mem_4K_touched        <- 0;
    stats.tags_now_set          <- 0;
    stats.tags_ever_set         <- 0;
    stats.tags_4K_now_set       <- 0;
    stats.tags_4K_ever_set      <- 0;
    stats.tags_16K_now_set      <- 0;
    stats.tags_16K_ever_set     <- 0;
    stats
}

string strStat (name::string,data::nat) =
    PadRight (#" ", 30, name)  : " = " : PadLeft (#" ", 10, [data])  : "\\n"

string strMemStats (pfx::string, memStats::MemStats) =
    strStat(pfx:"data_reads", memStats.data_reads):
    strStat(pfx:"data_writes", memStats.data_writes):
    strStat(pfx:"inst_reads", memStats.inst_reads):
    strStat(pfx:"valid_cap_reads", memStats.valid_cap_reads):
    strStat(pfx:"invalid_cap_reads", memStats.invalid_cap_reads):
    strStat(pfx:"valid_cap_writes", memStats.valid_cap_writes):
    strStat(pfx:"invalid_cap_writes", memStats.invalid_cap_writes):
    strStat(pfx:"working_set", memStats.working_set): " memory locations or " : [memStats.working_set * CAPBYTEWIDTH] : " bytes\\n" :
    strStat(pfx:"mem_4K_touched", memStats.mem_4K_touched): " (": [4096 div CAPBYTEWIDTH] :" memory locations or 4K bytes)\\n" :
    strStat(pfx:"tags_now_set", memStats.tags_now_set): " (one per memory location or " : [CAPBYTEWIDTH] : " bytes)\\n" :
    strStat(pfx:"tags_ever_set", memStats.tags_ever_set): " (one per memory location or " : [CAPBYTEWIDTH] : " bytes)\\n" :
    strStat(pfx:"tags_4K_now_set", memStats.tags_4K_now_set): " (one per ": [4096 div CAPBYTEWIDTH] :" memory location or 4K bytes)\\n" :
    strStat(pfx:"tags_4K_ever_set", memStats.tags_4K_ever_set): " (one per ": [4096 div CAPBYTEWIDTH] :" memory location or 4K bytes)\\n" :
    strStat(pfx:"tags_16K_now_set", memStats.tags_16K_now_set): " (one per ": [16384 div CAPBYTEWIDTH] :" memory location or 16K bytes)\\n" :
    strStat(pfx:"tags_16K_ever_set", memStats.tags_16K_ever_set): " (one per ": [16384 div CAPBYTEWIDTH] :" memory location or 16K bytes)\\n"

string strCsvHeaderMemStats (pfx::string) =
    pfx:"data_reads,":
    pfx:"data_writes,":
    pfx:"inst_reads,":
    pfx:"valid_cap_reads,":
    pfx:"invalid_cap_reads,":
    pfx:"valid_cap_writes,":
    pfx:"invalid_cap_writes,":
    pfx:"bytes_per_mem_location,":
    pfx:"working_set,":
    pfx:"mem_4K_touched,":
    pfx:"tags_now_set,":
    pfx:"tags_ever_set,":
    pfx:"tags_4K_now_set,":
    pfx:"tags_4K_ever_set,":
    pfx:"tags_16K_now_set,":
    pfx:"tags_16K_ever_set"

string strCsvMemStats (memStats::MemStats) =
    [memStats.data_reads] : "," :
    [memStats.data_writes] : "," :
    [memStats.inst_reads] : "," :
    [memStats.valid_cap_reads] : "," :
    [memStats.invalid_cap_reads] : "," :
    [memStats.valid_cap_writes] : "," :
    [memStats.invalid_cap_writes] : "," :
    [CAPBYTEWIDTH] : "," :
    [memStats.working_set] : "," :
    [memStats.mem_4K_touched] : "," :
    [memStats.tags_now_set] : "," :
    [memStats.tags_ever_set] : "," :
    [memStats.tags_4K_now_set] : "," :
    [memStats.tags_4K_ever_set] : "," :
    [memStats.tags_16K_now_set] : "," :
    [memStats.tags_16K_ever_set]

construct ShadowMem {memUntouched memR memW memRW}
construct ShadowTags {tagUnused tagTouched::bool}
declare static_shadow_MEM       :: CAPADDR  -> ShadowMem
declare static_shadow_4K_MEM    :: bits(52) -> ShadowMem
declare static_shadow_TAGS      :: CAPADDR  -> ShadowTags
declare static_shadow_4K_TAGS   :: bits(52) -> ShadowTags
declare static_shadow_16K_TAGS  :: bits(50) -> ShadowTags
declare dynamic_shadow_MEM      :: CAPADDR  -> ShadowMem
declare dynamic_shadow_4K_MEM   :: bits(52) -> ShadowMem
declare dynamic_shadow_TAGS     :: CAPADDR  -> ShadowTags
declare dynamic_shadow_4K_TAGS  :: bits(52) -> ShadowTags
declare dynamic_shadow_16K_TAGS :: bits(50) -> ShadowTags

declare staticMemStats  :: MemStats
declare dynamicMemStats :: MemStats

string printMemStats =
    "static memory count:\\n" : strMemStats("static_",staticMemStats) :
    "dynamic mem stats (for last sampled quantum)\\n" : strMemStats("dynamic_",dynamicMemStats)
string csvHeaderMemStats = strCsvHeaderMemStats("static_"):",":strCsvHeaderMemStats("dynamic_")
string csvMemStats = strCsvMemStats(staticMemStats):",":strCsvMemStats(dynamicMemStats)

unit initMemStats = 
{
    staticMemStats   <- nullMemStats;
    dynamicMemStats  <- nullMemStats
}

unit clearDynamicMemStats () =
{
    dynamic_shadow_MEM      <- InitMap (memUntouched);
    dynamic_shadow_4K_MEM   <- InitMap (memUntouched);
    dynamic_shadow_TAGS     <- InitMap (tagUnused);
    dynamic_shadow_4K_TAGS  <- InitMap (tagUnused);
    dynamic_shadow_16K_TAGS <- InitMap (tagUnused);
    dynamicMemStats         <- nullMemStats
}

unit stats_data_reads_updt (inc::int) =
{
    staticMemStats.data_reads  <- [[staticMemStats.data_reads] + inc];
    dynamicMemStats.data_reads <- [[dynamicMemStats.data_reads] + inc]
}
unit stats_data_writes_updt (inc::int) =
{
    staticMemStats.data_writes  <- [[staticMemStats.data_writes] + inc];
    dynamicMemStats.data_writes <- [[dynamicMemStats.data_writes] + inc]
}
unit stats_inst_reads_updt (inc::int) =
{
    staticMemStats.inst_reads  <- [[staticMemStats.inst_reads] + inc];
    dynamicMemStats.inst_reads <- [[dynamicMemStats.inst_reads] + inc]
}
unit stats_valid_cap_reads_updt (inc::int) =
{
    staticMemStats.valid_cap_reads  <- [[staticMemStats.valid_cap_reads] + inc];
    dynamicMemStats.valid_cap_reads <- [[dynamicMemStats.valid_cap_reads] + inc]
}
unit stats_valid_cap_writes_updt (inc::int) =
{
    staticMemStats.valid_cap_writes  <- [[staticMemStats.valid_cap_writes] + inc];
    dynamicMemStats.valid_cap_writes <- [[dynamicMemStats.valid_cap_writes] + inc]
}
unit stats_invalid_cap_reads_updt (inc::int) =
{
    staticMemStats.invalid_cap_reads  <- [[staticMemStats.invalid_cap_reads] + inc];
    dynamicMemStats.invalid_cap_reads <- [[dynamicMemStats.invalid_cap_reads] + inc]
}
unit stats_invalid_cap_writes_updt (inc::int) =
{
    staticMemStats.invalid_cap_writes  <- [[staticMemStats.invalid_cap_writes] + inc];
    dynamicMemStats.invalid_cap_writes <- [[dynamicMemStats.invalid_cap_writes] + inc]
}

unit updt_shadow_stats_read (addr::CAPADDR, data::DataType) =
{
    tagged = match data {case Cap(c) => getTag(c) case Raw(r) => false};
    match static_shadow_MEM(addr)
    {
        case memUntouched =>
        {
            static_shadow_MEM(addr) <- memR;
            staticMemStats.working_set  <- staticMemStats.working_set + 1
        }
        case memW => static_shadow_MEM(addr) <- memRW
        case _    => nothing
    };
    match dynamic_shadow_MEM(addr)
    {
        case memUntouched =>
        {
            dynamic_shadow_MEM(addr) <- memR;
            dynamicMemStats.working_set  <- dynamicMemStats.working_set + 1
        }
        case memW => dynamic_shadow_MEM(addr) <- memRW
        case _    => nothing
    };
    addr4k = [addr >>+ (12-Log2(CAPBYTEWIDTH))];
    match static_shadow_4K_MEM(addr4k)
    {
        case memUntouched =>
        {
            static_shadow_4K_MEM(addr4k)    <- memR;
            staticMemStats.mem_4K_touched   <- staticMemStats.mem_4K_touched + 1
        }
        case memW => static_shadow_4K_MEM(addr4k) <- memRW
        case _    => nothing
    };
    match dynamic_shadow_4K_MEM(addr4k)
    {
        case memUntouched =>
        {
            dynamic_shadow_4K_MEM(addr4k)   <- memR;
            dynamicMemStats.mem_4K_touched  <- dynamicMemStats.mem_4K_touched + 1
        }
        case memW => dynamic_shadow_4K_MEM(addr4k) <- memRW
        case _    => nothing
    }
}

unit updt_shadow_stats_write (addr::CAPADDR, data::DataType) =
{
    tagged = match data {case Cap(c) => getTag(c) case Raw(r) => false};
    match static_shadow_MEM(addr)
    {
        case memUntouched =>
        {
            static_shadow_MEM(addr) <- memW;
            staticMemStats.working_set  <- staticMemStats.working_set + 1
        }
        case memR => static_shadow_MEM(addr) <- memRW
        case _ => nothing
    };
    match static_shadow_TAGS(addr)
    {
        case tagUnused => when tagged do
        {
                static_shadow_TAGS(addr) <- tagTouched(true);
                staticMemStats.tags_ever_set <- staticMemStats.tags_ever_set + 1;
                staticMemStats.tags_now_set <- staticMemStats.tags_now_set + 1
        }
        case tagTouched(true) => when not tagged do
        {
                static_shadow_TAGS(addr) <- tagTouched(false);
                staticMemStats.tags_now_set <- staticMemStats.tags_now_set - 1
        }
        case tagTouched(false) => when tagged do
        {
                static_shadow_TAGS(addr) <- tagTouched(true);
                staticMemStats.tags_now_set <- staticMemStats.tags_now_set + 1
        }
    };
    addr4k = [addr >>+ (12-Log2(CAPBYTEWIDTH))];
    match static_shadow_4K_MEM(addr4k)
    {
        case memUntouched =>
        {
            static_shadow_4K_MEM(addr4k)    <- memW;
            staticMemStats.mem_4K_touched   <- staticMemStats.mem_4K_touched + 1
        }
        case memR => static_shadow_4K_MEM(addr4k) <- memRW
        case _ => nothing
    };
    match static_shadow_4K_TAGS(addr4k)
    {
        case tagUnused => when tagged do
        {
                static_shadow_4K_TAGS(addr4k) <- tagTouched(true);
                staticMemStats.tags_4K_ever_set <- staticMemStats.tags_4K_ever_set + 1;
                staticMemStats.tags_4K_now_set <- staticMemStats.tags_4K_now_set + 1
        }
        case tagTouched(true) => when not tagged do
        {
                static_shadow_4K_TAGS(addr4k) <- tagTouched(false);
                staticMemStats.tags_4K_now_set <- staticMemStats.tags_4K_now_set - 1
        }
        case tagTouched(false) => when tagged do
        {
                static_shadow_4K_TAGS(addr4k) <- tagTouched(true);
                staticMemStats.tags_4K_now_set <- staticMemStats.tags_4K_now_set + 1
        }
    };
    addr16k = [addr >>+ (14-Log2(CAPBYTEWIDTH))];
    match static_shadow_16K_TAGS(addr16k)
    {
        case tagUnused => when tagged do
        {
                static_shadow_16K_TAGS(addr16k) <- tagTouched(true);
                staticMemStats.tags_16K_ever_set <- staticMemStats.tags_16K_ever_set + 1;
                staticMemStats.tags_16K_now_set <- staticMemStats.tags_16K_now_set + 1
        }
        case tagTouched(true) => when not tagged do
        {
                static_shadow_16K_TAGS(addr16k) <- tagTouched(false);
                staticMemStats.tags_16K_now_set <- staticMemStats.tags_16K_now_set - 1
        }
        case tagTouched(false) => when tagged do
        {
                static_shadow_16K_TAGS(addr16k) <- tagTouched(true);
                staticMemStats.tags_16K_now_set <- staticMemStats.tags_16K_now_set + 1
        }
    };
    match dynamic_shadow_MEM(addr)
    {
        case memUntouched =>
        {
            dynamic_shadow_MEM(addr) <- memW;
            dynamicMemStats.working_set  <- dynamicMemStats.working_set + 1
        }
        case memR => dynamic_shadow_MEM(addr) <- memRW
        case _ => nothing
    };
    match dynamic_shadow_4K_MEM(addr4k)
    {
        case memUntouched =>
        {
            dynamic_shadow_4K_MEM(addr4k)   <- memW;
            dynamicMemStats.mem_4K_touched  <- dynamicMemStats.mem_4K_touched + 1
        }
        case memR => dynamic_shadow_4K_MEM(addr4k) <- memRW
        case _ => nothing
    };
    match dynamic_shadow_TAGS(addr)
    {
        case tagUnused => when tagged do
        {
                dynamic_shadow_TAGS(addr) <- tagTouched(true);
                dynamicMemStats.tags_ever_set <- dynamicMemStats.tags_ever_set + 1;
                dynamicMemStats.tags_now_set <- dynamicMemStats.tags_now_set + 1
        }
        case tagTouched(true) => when not tagged do
        {
                dynamic_shadow_TAGS(addr) <- tagTouched(false);
                dynamicMemStats.tags_now_set <- dynamicMemStats.tags_now_set - 1
        }
        case tagTouched(false) => when tagged do
        {
                dynamic_shadow_TAGS(addr) <- tagTouched(true);
                dynamicMemStats.tags_now_set <- dynamicMemStats.tags_now_set + 1
        }
    };
    match dynamic_shadow_4K_TAGS(addr4k)
    {
        case tagUnused => when tagged do
        {
                dynamic_shadow_4K_TAGS(addr4k) <- tagTouched(true);
                dynamicMemStats.tags_4K_ever_set <- dynamicMemStats.tags_4K_ever_set + 1;
                dynamicMemStats.tags_4K_now_set <- dynamicMemStats.tags_4K_now_set + 1
        }
        case tagTouched(true) => when not tagged do
        {
                dynamic_shadow_4K_TAGS(addr4k) <- tagTouched(false);
                dynamicMemStats.tags_4K_now_set <- dynamicMemStats.tags_4K_now_set - 1
        }
        case tagTouched(false) => when tagged do
        {
                dynamic_shadow_4K_TAGS(addr4k) <- tagTouched(true);
                dynamicMemStats.tags_4K_now_set <- dynamicMemStats.tags_4K_now_set + 1
        }
    };
    match dynamic_shadow_16K_TAGS(addr16k)
    {
        case tagUnused => when tagged do
        {
                dynamic_shadow_16K_TAGS(addr16k) <- tagTouched(true);
                dynamicMemStats.tags_16K_ever_set <- dynamicMemStats.tags_16K_ever_set + 1;
                dynamicMemStats.tags_16K_now_set <- dynamicMemStats.tags_16K_now_set + 1
        }
        case tagTouched(true) => when not tagged do
        {
                dynamic_shadow_16K_TAGS(addr16k) <- tagTouched(false);
                dynamicMemStats.tags_16K_now_set <- dynamicMemStats.tags_16K_now_set - 1
        }
        case tagTouched(false) => when tagged do
        {
                dynamic_shadow_16K_TAGS(addr16k) <- tagTouched(true);
                dynamicMemStats.tags_16K_now_set <- dynamicMemStats.tags_16K_now_set + 1
        }
    }
}

----------------------------
-- types and declarations --
----------------------------

declare the_MEM :: CAPADDR -> DataType -- physical memory (35 bits), capability access

component MEM (addr::CAPADDR) :: DataType
{
    -- READING --
    value = {
        data = the_MEM(addr);
        when not PROVER_EXPORT do
            updt_shadow_stats_read(addr,data);
        data
    }

    -- WRITING --
    assign value =
    {
        when not PROVER_EXPORT do
            updt_shadow_stats_write(addr,value);
        the_MEM(addr) <- value
    }
}

---------------------------
-- memory implementation --
---------------------------

unit InitMEM =
{
    static_shadow_MEM   <- InitMap (memUntouched);
    static_shadow_TAGS  <- InitMap (tagUnused);
    static_shadow_4K_TAGS <- InitMap (tagUnused);
    static_shadow_16K_TAGS  <- InitMap (tagUnused);
    dynamic_shadow_MEM  <- InitMap (memUntouched);
    dynamic_shadow_TAGS <- InitMap (tagUnused);
    dynamic_shadow_4K_TAGS <- InitMap (tagUnused);
    dynamic_shadow_16K_TAGS <- InitMap (tagUnused);
    the_MEM <- InitMap (Raw(UNKNOWN))
}

dword ReadData (dwordAddr::bits(37)) =
{
    stats_data_reads_updt(1);
    var data;
    match MEM(dwordAddr<36:(Log2(CAPBYTEWIDTH)-3)>)
    {
        case Cap (cap) =>
        {
            when getTag(cap) do
               -- shouldn't be done
               mark_log(5, "!!! normal read in valid cap !!!");
            data <- readDwordFromRaw (dwordAddr, capToBits(cap))
        }
        case Raw (raw) => data <- readDwordFromRaw (dwordAddr, raw)
    };
    mark_log(3, "read data ":hex (data):" from ":hex (dwordAddr:'0'));
    data
}

unit WriteData (dwordAddr::bits(37), data::dword, mask::dword) =
{
    stats_data_writes_updt(1);
    var old_blob;
    match the_MEM(dwordAddr<36:(Log2(CAPBYTEWIDTH)-3)>)
    {
        case Cap (cap) =>
        {
            when getTag(cap) do
               mark_log(5, "!!! normal write in valid cap !!!");
            old_blob <- capToBits(cap)
        }
        case Raw (raw) => old_blob <- raw
    };
    new_blob = updateDwordInRaw (dwordAddr, data, mask, old_blob);
    mark_log(3, "write data ":hex (data):" @ ":hex (dwordAddr:'0'));
    MEM(dwordAddr<36:(Log2(CAPBYTEWIDTH)-3)>) <- Raw(new_blob)
}

word ReadInst (a::pAddr) =
{
    stats_inst_reads_updt(1);
    var inst_pair;
    match MEM(a<39:Log2(CAPBYTEWIDTH)>)
    {
        case Cap (cap) =>
        {
            when getTag(cap) do
               -- shouldn't be done
               mark_log(5, "!!! instruction read in valid cap !!!");
            inst_pair <- readDwordFromRaw (a<39:3>, capToBits(cap))
        }
        case Raw (raw) => inst_pair <- readDwordFromRaw (a<39:3>, raw)
    };
    inst = if a<2> then inst_pair<31:0> else inst_pair<63:32>;
    mark_log(3, "read instruction ":hex (inst):" @":hex (a));
    inst
}

Capability ReadCap (capAddr::CAPADDR) =
{
    data = match MEM(capAddr)
    {
        case Cap (cap) => cap
        case Raw (raw) => bitsToCap(raw)
    };
    if getTag(data) then
        stats_valid_cap_reads_updt(1)
    else
        stats_invalid_cap_reads_updt(1);
    mark_log(4, "read " : (if getTag(data) then "valid" else "invalid") :
                " cap from " : hex (capAddr:'0'));
    data
}

unit WriteCap (capAddr::CAPADDR, cap::Capability) =
{
    MEM(capAddr) <- Cap (cap);
    if getTag(cap) then
        stats_valid_cap_writes_updt(1)
    else
        stats_invalid_cap_writes_updt(1);
    mark_log(4, "write " : (if getTag(cap) then "valid" else "invalid") :
                " cap @ " : hex (capAddr:'0'))
}

-- stub for configuring L2 cache
unit setL2 (replace_policy::nat, prefetch_depth::nat, l2_pefetcher::nat) = ()
