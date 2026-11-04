.class public Lorg/apache/commons/compress/compressors/brotli/BrotliUtils;
.super Ljava/lang/Object;
.source "BrotliUtils.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lorg/apache/commons/compress/compressors/brotli/BrotliUtils$CachedAvailability;
    }
.end annotation


# static fields
.field private static volatile cachedBrotliAvailability:Lorg/apache/commons/compress/compressors/brotli/BrotliUtils$CachedAvailability;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 37
    sget-object v0, Lorg/apache/commons/compress/compressors/brotli/BrotliUtils$CachedAvailability;->DONT_CACHE:Lorg/apache/commons/compress/compressors/brotli/BrotliUtils$CachedAvailability;

    sput-object v0, Lorg/apache/commons/compress/compressors/brotli/BrotliUtils;->cachedBrotliAvailability:Lorg/apache/commons/compress/compressors/brotli/BrotliUtils$CachedAvailability;

    .line 38
    invoke-static {}, Lorg/apache/commons/compress/utils/OsgiUtils;->isRunningInOsgiEnvironment()Z

    move-result v0

    xor-int/lit8 v0, v0, 0x1

    invoke-static {v0}, Lorg/apache/commons/compress/compressors/brotli/BrotliUtils;->setCacheBrotliAvailablity(Z)V

    .line 39
    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 42
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 43
    return-void
.end method

.method static getCachedBrotliAvailability()Lorg/apache/commons/compress/compressors/brotli/BrotliUtils$CachedAvailability;
    .locals 1

    .line 85
    sget-object v0, Lorg/apache/commons/compress/compressors/brotli/BrotliUtils;->cachedBrotliAvailability:Lorg/apache/commons/compress/compressors/brotli/BrotliUtils$CachedAvailability;

    return-object v0
.end method

.method private static internalIsBrotliCompressionAvailable()Z
    .locals 2

    .line 60
    :try_start_0
    const-string v0, "org.brotli.dec.BrotliInputStream"

    invoke-static {v0}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;
    :try_end_0
    .catch Ljava/lang/NoClassDefFoundError; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 61
    const/4 v0, 0x1

    return v0

    .line 62
    :catch_0
    move-exception v0

    goto :goto_0

    :catch_1
    move-exception v0

    .line 63
    .local v0, "error":Ljava/lang/Throwable;
    :goto_0
    const/4 v1, 0x0

    return v1
.end method

.method public static isBrotliCompressionAvailable()Z
    .locals 2

    .line 51
    sget-object v0, Lorg/apache/commons/compress/compressors/brotli/BrotliUtils;->cachedBrotliAvailability:Lorg/apache/commons/compress/compressors/brotli/BrotliUtils$CachedAvailability;

    .line 52
    .local v0, "cachedResult":Lorg/apache/commons/compress/compressors/brotli/BrotliUtils$CachedAvailability;
    sget-object v1, Lorg/apache/commons/compress/compressors/brotli/BrotliUtils$CachedAvailability;->DONT_CACHE:Lorg/apache/commons/compress/compressors/brotli/BrotliUtils$CachedAvailability;

    if-eq v0, v1, :cond_1

    .line 53
    sget-object v1, Lorg/apache/commons/compress/compressors/brotli/BrotliUtils$CachedAvailability;->CACHED_AVAILABLE:Lorg/apache/commons/compress/compressors/brotli/BrotliUtils$CachedAvailability;

    if-ne v0, v1, :cond_0

    const/4 v1, 0x1

    goto :goto_0

    :cond_0
    const/4 v1, 0x0

    :goto_0
    return v1

    .line 55
    :cond_1
    invoke-static {}, Lorg/apache/commons/compress/compressors/brotli/BrotliUtils;->internalIsBrotliCompressionAvailable()Z

    move-result v1

    return v1
.end method

.method public static setCacheBrotliAvailablity(Z)V
    .locals 2
    .param p0, "doCache"    # Z

    .line 74
    if-nez p0, :cond_0

    .line 75
    sget-object v0, Lorg/apache/commons/compress/compressors/brotli/BrotliUtils$CachedAvailability;->DONT_CACHE:Lorg/apache/commons/compress/compressors/brotli/BrotliUtils$CachedAvailability;

    sput-object v0, Lorg/apache/commons/compress/compressors/brotli/BrotliUtils;->cachedBrotliAvailability:Lorg/apache/commons/compress/compressors/brotli/BrotliUtils$CachedAvailability;

    goto :goto_1

    .line 76
    :cond_0
    sget-object v0, Lorg/apache/commons/compress/compressors/brotli/BrotliUtils;->cachedBrotliAvailability:Lorg/apache/commons/compress/compressors/brotli/BrotliUtils$CachedAvailability;

    sget-object v1, Lorg/apache/commons/compress/compressors/brotli/BrotliUtils$CachedAvailability;->DONT_CACHE:Lorg/apache/commons/compress/compressors/brotli/BrotliUtils$CachedAvailability;

    if-ne v0, v1, :cond_2

    .line 77
    invoke-static {}, Lorg/apache/commons/compress/compressors/brotli/BrotliUtils;->internalIsBrotliCompressionAvailable()Z

    move-result v0

    .line 78
    .local v0, "hasBrotli":Z
    if-eqz v0, :cond_1

    sget-object v1, Lorg/apache/commons/compress/compressors/brotli/BrotliUtils$CachedAvailability;->CACHED_AVAILABLE:Lorg/apache/commons/compress/compressors/brotli/BrotliUtils$CachedAvailability;

    goto :goto_0

    :cond_1
    sget-object v1, Lorg/apache/commons/compress/compressors/brotli/BrotliUtils$CachedAvailability;->CACHED_UNAVAILABLE:Lorg/apache/commons/compress/compressors/brotli/BrotliUtils$CachedAvailability;

    :goto_0
    sput-object v1, Lorg/apache/commons/compress/compressors/brotli/BrotliUtils;->cachedBrotliAvailability:Lorg/apache/commons/compress/compressors/brotli/BrotliUtils$CachedAvailability;

    .line 81
    .end local v0    # "hasBrotli":Z
    :cond_2
    :goto_1
    return-void
.end method
