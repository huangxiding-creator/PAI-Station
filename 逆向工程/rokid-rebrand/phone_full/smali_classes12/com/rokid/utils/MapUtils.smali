.class public Lcom/rokid/utils/MapUtils;
.super Ljava/lang/Object;
.source "MapUtils.java"


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 12
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static isNotNullAndNotEmpty(Ljava/util/Map;)Z
    .locals 1
    .param p0, "map"    # Ljava/util/Map;

    .line 19
    invoke-static {p0}, Lcom/rokid/utils/MapUtils;->isNullOrEmpty(Ljava/util/Map;)Z

    move-result v0

    xor-int/lit8 v0, v0, 0x1

    return v0
.end method

.method public static isNullOrEmpty(Ljava/util/Map;)Z
    .locals 2
    .param p0, "map"    # Ljava/util/Map;

    .line 15
    const/4 v0, 0x1

    if-eqz p0, :cond_1

    invoke-interface {p0}, Ljava/util/Map;->size()I

    move-result v1

    if-ge v1, v0, :cond_0

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :cond_1
    :goto_0
    return v0
.end method
