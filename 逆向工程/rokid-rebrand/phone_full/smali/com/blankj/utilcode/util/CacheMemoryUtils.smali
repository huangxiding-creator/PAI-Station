.class public final Lcom/blankj/utilcode/util/CacheMemoryUtils;
.super Ljava/lang/Object;
.source "CacheMemoryUtils.java"

# interfaces
.implements Lcom/blankj/utilcode/constant/CacheConstants;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/blankj/utilcode/util/CacheMemoryUtils$CacheValue;
    }
.end annotation


# static fields
.field private static final CACHE_MAP:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Lcom/blankj/utilcode/util/CacheMemoryUtils;",
            ">;"
        }
    .end annotation
.end field

.field private static final DEFAULT_MAX_COUNT:I = 0x100


# instance fields
.field private final mCacheKey:Ljava/lang/String;

.field private final mMemoryCache:Landroidx/collection/LruCache;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Landroidx/collection/LruCache<",
            "Ljava/lang/String;",
            "Lcom/blankj/utilcode/util/CacheMemoryUtils$CacheValue;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 23
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    sput-object v0, Lcom/blankj/utilcode/util/CacheMemoryUtils;->CACHE_MAP:Ljava/util/Map;

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;Landroidx/collection/LruCache;)V
    .locals 0
    .param p1, "cacheKey"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Landroidx/collection/LruCache<",
            "Ljava/lang/String;",
            "Lcom/blankj/utilcode/util/CacheMemoryUtils$CacheValue;",
            ">;)V"
        }
    .end annotation

    .line 68
    .local p2, "memoryCache":Landroidx/collection/LruCache;, "Landroidx/collection/LruCache<Ljava/lang/String;Lcom/blankj/utilcode/util/CacheMemoryUtils$CacheValue;>;"
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 69
    iput-object p1, p0, Lcom/blankj/utilcode/util/CacheMemoryUtils;->mCacheKey:Ljava/lang/String;

    .line 70
    iput-object p2, p0, Lcom/blankj/utilcode/util/CacheMemoryUtils;->mMemoryCache:Landroidx/collection/LruCache;

    .line 71
    return-void
.end method

.method public static getInstance()Lcom/blankj/utilcode/util/CacheMemoryUtils;
    .locals 1

    .line 34
    const/16 v0, 0x100

    invoke-static {v0}, Lcom/blankj/utilcode/util/CacheMemoryUtils;->getInstance(I)Lcom/blankj/utilcode/util/CacheMemoryUtils;

    move-result-object v0

    return-object v0
.end method

.method public static getInstance(I)Lcom/blankj/utilcode/util/CacheMemoryUtils;
    .locals 1
    .param p0, "maxCount"    # I

    .line 44
    invoke-static {p0}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0, p0}, Lcom/blankj/utilcode/util/CacheMemoryUtils;->getInstance(Ljava/lang/String;I)Lcom/blankj/utilcode/util/CacheMemoryUtils;

    move-result-object v0

    return-object v0
.end method

.method public static getInstance(Ljava/lang/String;I)Lcom/blankj/utilcode/util/CacheMemoryUtils;
    .locals 4
    .param p0, "cacheKey"    # Ljava/lang/String;
    .param p1, "maxCount"    # I

    .line 55
    sget-object v0, Lcom/blankj/utilcode/util/CacheMemoryUtils;->CACHE_MAP:Ljava/util/Map;

    invoke-interface {v0, p0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/blankj/utilcode/util/CacheMemoryUtils;

    .line 56
    .local v0, "cache":Lcom/blankj/utilcode/util/CacheMemoryUtils;
    if-nez v0, :cond_1

    .line 57
    const-class v1, Lcom/blankj/utilcode/util/CacheMemoryUtils;

    monitor-enter v1

    .line 58
    :try_start_0
    sget-object v2, Lcom/blankj/utilcode/util/CacheMemoryUtils;->CACHE_MAP:Ljava/util/Map;

    invoke-interface {v2, p0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/blankj/utilcode/util/CacheMemoryUtils;

    move-object v0, v2

    .line 59
    if-nez v0, :cond_0

    .line 60
    new-instance v2, Lcom/blankj/utilcode/util/CacheMemoryUtils;

    new-instance v3, Landroidx/collection/LruCache;

    invoke-direct {v3, p1}, Landroidx/collection/LruCache;-><init>(I)V

    invoke-direct {v2, p0, v3}, Lcom/blankj/utilcode/util/CacheMemoryUtils;-><init>(Ljava/lang/String;Landroidx/collection/LruCache;)V

    move-object v0, v2

    .line 61
    sget-object v2, Lcom/blankj/utilcode/util/CacheMemoryUtils;->CACHE_MAP:Ljava/util/Map;

    invoke-interface {v2, p0, v0}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 63
    :cond_0
    monitor-exit v1

    goto :goto_0

    :catchall_0
    move-exception v2

    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v2

    .line 65
    :cond_1
    :goto_0
    return-object v0
.end method


# virtual methods
.method public clear()V
    .locals 1

    .line 156
    iget-object v0, p0, Lcom/blankj/utilcode/util/CacheMemoryUtils;->mMemoryCache:Landroidx/collection/LruCache;

    invoke-virtual {v0}, Landroidx/collection/LruCache;->evictAll()V

    .line 157
    return-void
.end method

.method public get(Ljava/lang/String;)Ljava/lang/Object;
    .locals 1
    .param p1, "key"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T:",
            "Ljava/lang/Object;",
            ">(",
            "Ljava/lang/String;",
            ")TT;"
        }
    .end annotation

    .line 109
    const/4 v0, 0x0

    invoke-virtual {p0, p1, v0}, Lcom/blankj/utilcode/util/CacheMemoryUtils;->get(Ljava/lang/String;Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public get(Ljava/lang/String;Ljava/lang/Object;)Ljava/lang/Object;
    .locals 5
    .param p1, "key"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T:",
            "Ljava/lang/Object;",
            ">(",
            "Ljava/lang/String;",
            "TT;)TT;"
        }
    .end annotation

    .line 121
    .local p2, "defaultValue":Ljava/lang/Object;, "TT;"
    iget-object v0, p0, Lcom/blankj/utilcode/util/CacheMemoryUtils;->mMemoryCache:Landroidx/collection/LruCache;

    invoke-virtual {v0, p1}, Landroidx/collection/LruCache;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/blankj/utilcode/util/CacheMemoryUtils$CacheValue;

    .line 122
    .local v0, "val":Lcom/blankj/utilcode/util/CacheMemoryUtils$CacheValue;
    if-nez v0, :cond_0

    return-object p2

    .line 123
    :cond_0
    iget-wide v1, v0, Lcom/blankj/utilcode/util/CacheMemoryUtils$CacheValue;->dueTime:J

    const-wide/16 v3, -0x1

    cmp-long v1, v1, v3

    if-eqz v1, :cond_2

    iget-wide v1, v0, Lcom/blankj/utilcode/util/CacheMemoryUtils$CacheValue;->dueTime:J

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v3

    cmp-long v1, v1, v3

    if-ltz v1, :cond_1

    goto :goto_0

    .line 127
    :cond_1
    iget-object v1, p0, Lcom/blankj/utilcode/util/CacheMemoryUtils;->mMemoryCache:Landroidx/collection/LruCache;

    invoke-virtual {v1, p1}, Landroidx/collection/LruCache;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    .line 128
    return-object p2

    .line 125
    :cond_2
    :goto_0
    iget-object v1, v0, Lcom/blankj/utilcode/util/CacheMemoryUtils$CacheValue;->value:Ljava/lang/Object;

    return-object v1
.end method

.method public getCacheCount()I
    .locals 1

    .line 137
    iget-object v0, p0, Lcom/blankj/utilcode/util/CacheMemoryUtils;->mMemoryCache:Landroidx/collection/LruCache;

    invoke-virtual {v0}, Landroidx/collection/LruCache;->size()I

    move-result v0

    return v0
.end method

.method public put(Ljava/lang/String;Ljava/lang/Object;)V
    .locals 1
    .param p1, "key"    # Ljava/lang/String;
    .param p2, "value"    # Ljava/lang/Object;

    .line 85
    const/4 v0, -0x1

    invoke-virtual {p0, p1, p2, v0}, Lcom/blankj/utilcode/util/CacheMemoryUtils;->put(Ljava/lang/String;Ljava/lang/Object;I)V

    .line 86
    return-void
.end method

.method public put(Ljava/lang/String;Ljava/lang/Object;I)V
    .locals 4
    .param p1, "key"    # Ljava/lang/String;
    .param p2, "value"    # Ljava/lang/Object;
    .param p3, "saveTime"    # I

    .line 96
    if-nez p2, :cond_0

    return-void

    .line 97
    :cond_0
    if-gez p3, :cond_1

    const-wide/16 v0, -0x1

    goto :goto_0

    :cond_1
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    mul-int/lit16 v2, p3, 0x3e8

    int-to-long v2, v2

    add-long/2addr v0, v2

    .line 98
    .local v0, "dueTime":J
    :goto_0
    iget-object v2, p0, Lcom/blankj/utilcode/util/CacheMemoryUtils;->mMemoryCache:Landroidx/collection/LruCache;

    new-instance v3, Lcom/blankj/utilcode/util/CacheMemoryUtils$CacheValue;

    invoke-direct {v3, v0, v1, p2}, Lcom/blankj/utilcode/util/CacheMemoryUtils$CacheValue;-><init>(JLjava/lang/Object;)V

    invoke-virtual {v2, p1, v3}, Landroidx/collection/LruCache;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 99
    return-void
.end method

.method public remove(Ljava/lang/String;)Ljava/lang/Object;
    .locals 2
    .param p1, "key"    # Ljava/lang/String;

    .line 147
    iget-object v0, p0, Lcom/blankj/utilcode/util/CacheMemoryUtils;->mMemoryCache:Landroidx/collection/LruCache;

    invoke-virtual {v0, p1}, Landroidx/collection/LruCache;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/blankj/utilcode/util/CacheMemoryUtils$CacheValue;

    .line 148
    .local v0, "remove":Lcom/blankj/utilcode/util/CacheMemoryUtils$CacheValue;
    if-nez v0, :cond_0

    const/4 v1, 0x0

    return-object v1

    .line 149
    :cond_0
    iget-object v1, v0, Lcom/blankj/utilcode/util/CacheMemoryUtils$CacheValue;->value:Ljava/lang/Object;

    return-object v1
.end method

.method public toString()Ljava/lang/String;
    .locals 2

    .line 75
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v1, p0, Lcom/blankj/utilcode/util/CacheMemoryUtils;->mCacheKey:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "@"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {p0}, Ljava/lang/Object;->hashCode()I

    move-result v1

    invoke-static {v1}, Ljava/lang/Integer;->toHexString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
