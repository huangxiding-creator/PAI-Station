.class public final Lcom/blankj/utilcode/util/CacheDiskStaticUtils;
.super Ljava/lang/Object;
.source "CacheDiskStaticUtils.java"


# static fields
.field private static sDefaultCacheDiskUtils:Lcom/blankj/utilcode/util/CacheDiskUtils;


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 23
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static clear()Z
    .locals 1

    .line 445
    invoke-static {}, Lcom/blankj/utilcode/util/CacheDiskStaticUtils;->getDefaultCacheDiskUtils()Lcom/blankj/utilcode/util/CacheDiskUtils;

    move-result-object v0

    invoke-static {v0}, Lcom/blankj/utilcode/util/CacheDiskStaticUtils;->clear(Lcom/blankj/utilcode/util/CacheDiskUtils;)Z

    move-result v0

    return v0
.end method

.method public static clear(Lcom/blankj/utilcode/util/CacheDiskUtils;)Z
    .locals 1
    .param p0, "cacheDiskUtils"    # Lcom/blankj/utilcode/util/CacheDiskUtils;

    .line 951
    invoke-virtual {p0}, Lcom/blankj/utilcode/util/CacheDiskUtils;->clear()Z

    move-result v0

    return v0
.end method

.method public static getBitmap(Ljava/lang/String;)Landroid/graphics/Bitmap;
    .locals 1
    .param p0, "key"    # Ljava/lang/String;

    .line 252
    invoke-static {}, Lcom/blankj/utilcode/util/CacheDiskStaticUtils;->getDefaultCacheDiskUtils()Lcom/blankj/utilcode/util/CacheDiskUtils;

    move-result-object v0

    invoke-static {p0, v0}, Lcom/blankj/utilcode/util/CacheDiskStaticUtils;->getBitmap(Ljava/lang/String;Lcom/blankj/utilcode/util/CacheDiskUtils;)Landroid/graphics/Bitmap;

    move-result-object v0

    return-object v0
.end method

.method public static getBitmap(Ljava/lang/String;Landroid/graphics/Bitmap;)Landroid/graphics/Bitmap;
    .locals 1
    .param p0, "key"    # Ljava/lang/String;
    .param p1, "defaultValue"    # Landroid/graphics/Bitmap;

    .line 263
    invoke-static {}, Lcom/blankj/utilcode/util/CacheDiskStaticUtils;->getDefaultCacheDiskUtils()Lcom/blankj/utilcode/util/CacheDiskUtils;

    move-result-object v0

    invoke-static {p0, p1, v0}, Lcom/blankj/utilcode/util/CacheDiskStaticUtils;->getBitmap(Ljava/lang/String;Landroid/graphics/Bitmap;Lcom/blankj/utilcode/util/CacheDiskUtils;)Landroid/graphics/Bitmap;

    move-result-object v0

    return-object v0
.end method

.method public static getBitmap(Ljava/lang/String;Landroid/graphics/Bitmap;Lcom/blankj/utilcode/util/CacheDiskUtils;)Landroid/graphics/Bitmap;
    .locals 1
    .param p0, "key"    # Ljava/lang/String;
    .param p1, "defaultValue"    # Landroid/graphics/Bitmap;
    .param p2, "cacheDiskUtils"    # Lcom/blankj/utilcode/util/CacheDiskUtils;

    .line 732
    invoke-virtual {p2, p0, p1}, Lcom/blankj/utilcode/util/CacheDiskUtils;->getBitmap(Ljava/lang/String;Landroid/graphics/Bitmap;)Landroid/graphics/Bitmap;

    move-result-object v0

    return-object v0
.end method

.method public static getBitmap(Ljava/lang/String;Lcom/blankj/utilcode/util/CacheDiskUtils;)Landroid/graphics/Bitmap;
    .locals 1
    .param p0, "key"    # Ljava/lang/String;
    .param p1, "cacheDiskUtils"    # Lcom/blankj/utilcode/util/CacheDiskUtils;

    .line 718
    invoke-virtual {p1, p0}, Lcom/blankj/utilcode/util/CacheDiskUtils;->getBitmap(Ljava/lang/String;)Landroid/graphics/Bitmap;

    move-result-object v0

    return-object v0
.end method

.method public static getBytes(Ljava/lang/String;)[B
    .locals 1
    .param p0, "key"    # Ljava/lang/String;

    .line 64
    invoke-static {}, Lcom/blankj/utilcode/util/CacheDiskStaticUtils;->getDefaultCacheDiskUtils()Lcom/blankj/utilcode/util/CacheDiskUtils;

    move-result-object v0

    invoke-static {p0, v0}, Lcom/blankj/utilcode/util/CacheDiskStaticUtils;->getBytes(Ljava/lang/String;Lcom/blankj/utilcode/util/CacheDiskUtils;)[B

    move-result-object v0

    return-object v0
.end method

.method public static getBytes(Ljava/lang/String;Lcom/blankj/utilcode/util/CacheDiskUtils;)[B
    .locals 1
    .param p0, "key"    # Ljava/lang/String;
    .param p1, "cacheDiskUtils"    # Lcom/blankj/utilcode/util/CacheDiskUtils;

    .line 488
    invoke-virtual {p1, p0}, Lcom/blankj/utilcode/util/CacheDiskUtils;->getBytes(Ljava/lang/String;)[B

    move-result-object v0

    return-object v0
.end method

.method public static getBytes(Ljava/lang/String;[B)[B
    .locals 1
    .param p0, "key"    # Ljava/lang/String;
    .param p1, "defaultValue"    # [B

    .line 75
    invoke-static {}, Lcom/blankj/utilcode/util/CacheDiskStaticUtils;->getDefaultCacheDiskUtils()Lcom/blankj/utilcode/util/CacheDiskUtils;

    move-result-object v0

    invoke-static {p0, p1, v0}, Lcom/blankj/utilcode/util/CacheDiskStaticUtils;->getBytes(Ljava/lang/String;[BLcom/blankj/utilcode/util/CacheDiskUtils;)[B

    move-result-object v0

    return-object v0
.end method

.method public static getBytes(Ljava/lang/String;[BLcom/blankj/utilcode/util/CacheDiskUtils;)[B
    .locals 1
    .param p0, "key"    # Ljava/lang/String;
    .param p1, "defaultValue"    # [B
    .param p2, "cacheDiskUtils"    # Lcom/blankj/utilcode/util/CacheDiskUtils;

    .line 502
    invoke-virtual {p2, p0, p1}, Lcom/blankj/utilcode/util/CacheDiskUtils;->getBytes(Ljava/lang/String;[B)[B

    move-result-object v0

    return-object v0
.end method

.method public static getCacheCount()I
    .locals 1

    .line 426
    invoke-static {}, Lcom/blankj/utilcode/util/CacheDiskStaticUtils;->getDefaultCacheDiskUtils()Lcom/blankj/utilcode/util/CacheDiskUtils;

    move-result-object v0

    invoke-static {v0}, Lcom/blankj/utilcode/util/CacheDiskStaticUtils;->getCacheCount(Lcom/blankj/utilcode/util/CacheDiskUtils;)I

    move-result v0

    return v0
.end method

.method public static getCacheCount(Lcom/blankj/utilcode/util/CacheDiskUtils;)I
    .locals 1
    .param p0, "cacheDiskUtils"    # Lcom/blankj/utilcode/util/CacheDiskUtils;

    .line 930
    invoke-virtual {p0}, Lcom/blankj/utilcode/util/CacheDiskUtils;->getCacheCount()I

    move-result v0

    return v0
.end method

.method public static getCacheSize()J
    .locals 2

    .line 417
    invoke-static {}, Lcom/blankj/utilcode/util/CacheDiskStaticUtils;->getDefaultCacheDiskUtils()Lcom/blankj/utilcode/util/CacheDiskUtils;

    move-result-object v0

    invoke-static {v0}, Lcom/blankj/utilcode/util/CacheDiskStaticUtils;->getCacheSize(Lcom/blankj/utilcode/util/CacheDiskUtils;)J

    move-result-wide v0

    return-wide v0
.end method

.method public static getCacheSize(Lcom/blankj/utilcode/util/CacheDiskUtils;)J
    .locals 2
    .param p0, "cacheDiskUtils"    # Lcom/blankj/utilcode/util/CacheDiskUtils;

    .line 920
    invoke-virtual {p0}, Lcom/blankj/utilcode/util/CacheDiskUtils;->getCacheSize()J

    move-result-wide v0

    return-wide v0
.end method

.method private static getDefaultCacheDiskUtils()Lcom/blankj/utilcode/util/CacheDiskUtils;
    .locals 1

    .line 956
    sget-object v0, Lcom/blankj/utilcode/util/CacheDiskStaticUtils;->sDefaultCacheDiskUtils:Lcom/blankj/utilcode/util/CacheDiskUtils;

    if-eqz v0, :cond_0

    sget-object v0, Lcom/blankj/utilcode/util/CacheDiskStaticUtils;->sDefaultCacheDiskUtils:Lcom/blankj/utilcode/util/CacheDiskUtils;

    goto :goto_0

    :cond_0
    invoke-static {}, Lcom/blankj/utilcode/util/CacheDiskUtils;->getInstance()Lcom/blankj/utilcode/util/CacheDiskUtils;

    move-result-object v0

    :goto_0
    return-object v0
.end method

.method public static getDrawable(Ljava/lang/String;)Landroid/graphics/drawable/Drawable;
    .locals 1
    .param p0, "key"    # Ljava/lang/String;

    .line 298
    invoke-static {}, Lcom/blankj/utilcode/util/CacheDiskStaticUtils;->getDefaultCacheDiskUtils()Lcom/blankj/utilcode/util/CacheDiskUtils;

    move-result-object v0

    invoke-static {p0, v0}, Lcom/blankj/utilcode/util/CacheDiskStaticUtils;->getDrawable(Ljava/lang/String;Lcom/blankj/utilcode/util/CacheDiskUtils;)Landroid/graphics/drawable/Drawable;

    move-result-object v0

    return-object v0
.end method

.method public static getDrawable(Ljava/lang/String;Landroid/graphics/drawable/Drawable;)Landroid/graphics/drawable/Drawable;
    .locals 1
    .param p0, "key"    # Ljava/lang/String;
    .param p1, "defaultValue"    # Landroid/graphics/drawable/Drawable;

    .line 309
    invoke-static {}, Lcom/blankj/utilcode/util/CacheDiskStaticUtils;->getDefaultCacheDiskUtils()Lcom/blankj/utilcode/util/CacheDiskUtils;

    move-result-object v0

    invoke-static {p0, p1, v0}, Lcom/blankj/utilcode/util/CacheDiskStaticUtils;->getDrawable(Ljava/lang/String;Landroid/graphics/drawable/Drawable;Lcom/blankj/utilcode/util/CacheDiskUtils;)Landroid/graphics/drawable/Drawable;

    move-result-object v0

    return-object v0
.end method

.method public static getDrawable(Ljava/lang/String;Landroid/graphics/drawable/Drawable;Lcom/blankj/utilcode/util/CacheDiskUtils;)Landroid/graphics/drawable/Drawable;
    .locals 1
    .param p0, "key"    # Ljava/lang/String;
    .param p1, "defaultValue"    # Landroid/graphics/drawable/Drawable;
    .param p2, "cacheDiskUtils"    # Lcom/blankj/utilcode/util/CacheDiskUtils;

    .line 789
    invoke-virtual {p2, p0, p1}, Lcom/blankj/utilcode/util/CacheDiskUtils;->getDrawable(Ljava/lang/String;Landroid/graphics/drawable/Drawable;)Landroid/graphics/drawable/Drawable;

    move-result-object v0

    return-object v0
.end method

.method public static getDrawable(Ljava/lang/String;Lcom/blankj/utilcode/util/CacheDiskUtils;)Landroid/graphics/drawable/Drawable;
    .locals 1
    .param p0, "key"    # Ljava/lang/String;
    .param p1, "cacheDiskUtils"    # Lcom/blankj/utilcode/util/CacheDiskUtils;

    .line 775
    invoke-virtual {p1, p0}, Lcom/blankj/utilcode/util/CacheDiskUtils;->getDrawable(Ljava/lang/String;)Landroid/graphics/drawable/Drawable;

    move-result-object v0

    return-object v0
.end method

.method public static getJSONArray(Ljava/lang/String;)Lorg/json/JSONArray;
    .locals 1
    .param p0, "key"    # Ljava/lang/String;

    .line 205
    invoke-static {}, Lcom/blankj/utilcode/util/CacheDiskStaticUtils;->getDefaultCacheDiskUtils()Lcom/blankj/utilcode/util/CacheDiskUtils;

    move-result-object v0

    invoke-static {p0, v0}, Lcom/blankj/utilcode/util/CacheDiskStaticUtils;->getJSONArray(Ljava/lang/String;Lcom/blankj/utilcode/util/CacheDiskUtils;)Lorg/json/JSONArray;

    move-result-object v0

    return-object v0
.end method

.method public static getJSONArray(Ljava/lang/String;Lcom/blankj/utilcode/util/CacheDiskUtils;)Lorg/json/JSONArray;
    .locals 1
    .param p0, "key"    # Ljava/lang/String;
    .param p1, "cacheDiskUtils"    # Lcom/blankj/utilcode/util/CacheDiskUtils;

    .line 660
    invoke-virtual {p1, p0}, Lcom/blankj/utilcode/util/CacheDiskUtils;->getJSONArray(Ljava/lang/String;)Lorg/json/JSONArray;

    move-result-object v0

    return-object v0
.end method

.method public static getJSONArray(Ljava/lang/String;Lorg/json/JSONArray;)Lorg/json/JSONArray;
    .locals 1
    .param p0, "key"    # Ljava/lang/String;
    .param p1, "defaultValue"    # Lorg/json/JSONArray;

    .line 216
    invoke-static {}, Lcom/blankj/utilcode/util/CacheDiskStaticUtils;->getDefaultCacheDiskUtils()Lcom/blankj/utilcode/util/CacheDiskUtils;

    move-result-object v0

    invoke-static {p0, p1, v0}, Lcom/blankj/utilcode/util/CacheDiskStaticUtils;->getJSONArray(Ljava/lang/String;Lorg/json/JSONArray;Lcom/blankj/utilcode/util/CacheDiskUtils;)Lorg/json/JSONArray;

    move-result-object v0

    return-object v0
.end method

.method public static getJSONArray(Ljava/lang/String;Lorg/json/JSONArray;Lcom/blankj/utilcode/util/CacheDiskUtils;)Lorg/json/JSONArray;
    .locals 1
    .param p0, "key"    # Ljava/lang/String;
    .param p1, "defaultValue"    # Lorg/json/JSONArray;
    .param p2, "cacheDiskUtils"    # Lcom/blankj/utilcode/util/CacheDiskUtils;

    .line 674
    invoke-virtual {p2, p0, p1}, Lcom/blankj/utilcode/util/CacheDiskUtils;->getJSONArray(Ljava/lang/String;Lorg/json/JSONArray;)Lorg/json/JSONArray;

    move-result-object v0

    return-object v0
.end method

.method public static getJSONObject(Ljava/lang/String;)Lorg/json/JSONObject;
    .locals 1
    .param p0, "key"    # Ljava/lang/String;

    .line 158
    invoke-static {}, Lcom/blankj/utilcode/util/CacheDiskStaticUtils;->getDefaultCacheDiskUtils()Lcom/blankj/utilcode/util/CacheDiskUtils;

    move-result-object v0

    invoke-static {p0, v0}, Lcom/blankj/utilcode/util/CacheDiskStaticUtils;->getJSONObject(Ljava/lang/String;Lcom/blankj/utilcode/util/CacheDiskUtils;)Lorg/json/JSONObject;

    move-result-object v0

    return-object v0
.end method

.method public static getJSONObject(Ljava/lang/String;Lcom/blankj/utilcode/util/CacheDiskUtils;)Lorg/json/JSONObject;
    .locals 1
    .param p0, "key"    # Ljava/lang/String;
    .param p1, "cacheDiskUtils"    # Lcom/blankj/utilcode/util/CacheDiskUtils;

    .line 602
    invoke-virtual {p1, p0}, Lcom/blankj/utilcode/util/CacheDiskUtils;->getJSONObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v0

    return-object v0
.end method

.method public static getJSONObject(Ljava/lang/String;Lorg/json/JSONObject;)Lorg/json/JSONObject;
    .locals 1
    .param p0, "key"    # Ljava/lang/String;
    .param p1, "defaultValue"    # Lorg/json/JSONObject;

    .line 169
    invoke-static {}, Lcom/blankj/utilcode/util/CacheDiskStaticUtils;->getDefaultCacheDiskUtils()Lcom/blankj/utilcode/util/CacheDiskUtils;

    move-result-object v0

    invoke-static {p0, p1, v0}, Lcom/blankj/utilcode/util/CacheDiskStaticUtils;->getJSONObject(Ljava/lang/String;Lorg/json/JSONObject;Lcom/blankj/utilcode/util/CacheDiskUtils;)Lorg/json/JSONObject;

    move-result-object v0

    return-object v0
.end method

.method public static getJSONObject(Ljava/lang/String;Lorg/json/JSONObject;Lcom/blankj/utilcode/util/CacheDiskUtils;)Lorg/json/JSONObject;
    .locals 1
    .param p0, "key"    # Ljava/lang/String;
    .param p1, "defaultValue"    # Lorg/json/JSONObject;
    .param p2, "cacheDiskUtils"    # Lcom/blankj/utilcode/util/CacheDiskUtils;

    .line 616
    invoke-virtual {p2, p0, p1}, Lcom/blankj/utilcode/util/CacheDiskUtils;->getJSONObject(Ljava/lang/String;Lorg/json/JSONObject;)Lorg/json/JSONObject;

    move-result-object v0

    return-object v0
.end method

.method public static getParcelable(Ljava/lang/String;Landroid/os/Parcelable$Creator;)Ljava/lang/Object;
    .locals 1
    .param p0, "key"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T:",
            "Ljava/lang/Object;",
            ">(",
            "Ljava/lang/String;",
            "Landroid/os/Parcelable$Creator<",
            "TT;>;)TT;"
        }
    .end annotation

    .line 347
    .local p1, "creator":Landroid/os/Parcelable$Creator;, "Landroid/os/Parcelable$Creator<TT;>;"
    invoke-static {}, Lcom/blankj/utilcode/util/CacheDiskStaticUtils;->getDefaultCacheDiskUtils()Lcom/blankj/utilcode/util/CacheDiskUtils;

    move-result-object v0

    invoke-static {p0, p1, v0}, Lcom/blankj/utilcode/util/CacheDiskStaticUtils;->getParcelable(Ljava/lang/String;Landroid/os/Parcelable$Creator;Lcom/blankj/utilcode/util/CacheDiskUtils;)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public static getParcelable(Ljava/lang/String;Landroid/os/Parcelable$Creator;Lcom/blankj/utilcode/util/CacheDiskUtils;)Ljava/lang/Object;
    .locals 1
    .param p0, "key"    # Ljava/lang/String;
    .param p2, "cacheDiskUtils"    # Lcom/blankj/utilcode/util/CacheDiskUtils;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T:",
            "Ljava/lang/Object;",
            ">(",
            "Ljava/lang/String;",
            "Landroid/os/Parcelable$Creator<",
            "TT;>;",
            "Lcom/blankj/utilcode/util/CacheDiskUtils;",
            ")TT;"
        }
    .end annotation

    .line 836
    .local p1, "creator":Landroid/os/Parcelable$Creator;, "Landroid/os/Parcelable$Creator<TT;>;"
    invoke-virtual {p2, p0, p1}, Lcom/blankj/utilcode/util/CacheDiskUtils;->getParcelable(Ljava/lang/String;Landroid/os/Parcelable$Creator;)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public static getParcelable(Ljava/lang/String;Landroid/os/Parcelable$Creator;Ljava/lang/Object;)Ljava/lang/Object;
    .locals 1
    .param p0, "key"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T:",
            "Ljava/lang/Object;",
            ">(",
            "Ljava/lang/String;",
            "Landroid/os/Parcelable$Creator<",
            "TT;>;TT;)TT;"
        }
    .end annotation

    .line 362
    .local p1, "creator":Landroid/os/Parcelable$Creator;, "Landroid/os/Parcelable$Creator<TT;>;"
    .local p2, "defaultValue":Ljava/lang/Object;, "TT;"
    invoke-static {}, Lcom/blankj/utilcode/util/CacheDiskStaticUtils;->getDefaultCacheDiskUtils()Lcom/blankj/utilcode/util/CacheDiskUtils;

    move-result-object v0

    invoke-static {p0, p1, p2, v0}, Lcom/blankj/utilcode/util/CacheDiskStaticUtils;->getParcelable(Ljava/lang/String;Landroid/os/Parcelable$Creator;Ljava/lang/Object;Lcom/blankj/utilcode/util/CacheDiskUtils;)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public static getParcelable(Ljava/lang/String;Landroid/os/Parcelable$Creator;Ljava/lang/Object;Lcom/blankj/utilcode/util/CacheDiskUtils;)Ljava/lang/Object;
    .locals 1
    .param p0, "key"    # Ljava/lang/String;
    .param p3, "cacheDiskUtils"    # Lcom/blankj/utilcode/util/CacheDiskUtils;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T:",
            "Ljava/lang/Object;",
            ">(",
            "Ljava/lang/String;",
            "Landroid/os/Parcelable$Creator<",
            "TT;>;TT;",
            "Lcom/blankj/utilcode/util/CacheDiskUtils;",
            ")TT;"
        }
    .end annotation

    .line 853
    .local p1, "creator":Landroid/os/Parcelable$Creator;, "Landroid/os/Parcelable$Creator<TT;>;"
    .local p2, "defaultValue":Ljava/lang/Object;, "TT;"
    invoke-virtual {p3, p0, p1, p2}, Lcom/blankj/utilcode/util/CacheDiskUtils;->getParcelable(Ljava/lang/String;Landroid/os/Parcelable$Creator;Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public static getSerializable(Ljava/lang/String;)Ljava/lang/Object;
    .locals 1
    .param p0, "key"    # Ljava/lang/String;

    .line 397
    invoke-static {}, Lcom/blankj/utilcode/util/CacheDiskStaticUtils;->getDefaultCacheDiskUtils()Lcom/blankj/utilcode/util/CacheDiskUtils;

    move-result-object v0

    invoke-static {p0, v0}, Lcom/blankj/utilcode/util/CacheDiskStaticUtils;->getSerializable(Ljava/lang/String;Lcom/blankj/utilcode/util/CacheDiskUtils;)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public static getSerializable(Ljava/lang/String;Lcom/blankj/utilcode/util/CacheDiskUtils;)Ljava/lang/Object;
    .locals 1
    .param p0, "key"    # Ljava/lang/String;
    .param p1, "cacheDiskUtils"    # Lcom/blankj/utilcode/util/CacheDiskUtils;

    .line 896
    invoke-virtual {p1, p0}, Lcom/blankj/utilcode/util/CacheDiskUtils;->getSerializable(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public static getSerializable(Ljava/lang/String;Ljava/lang/Object;)Ljava/lang/Object;
    .locals 1
    .param p0, "key"    # Ljava/lang/String;
    .param p1, "defaultValue"    # Ljava/lang/Object;

    .line 408
    invoke-static {}, Lcom/blankj/utilcode/util/CacheDiskStaticUtils;->getDefaultCacheDiskUtils()Lcom/blankj/utilcode/util/CacheDiskUtils;

    move-result-object v0

    invoke-static {p0, p1, v0}, Lcom/blankj/utilcode/util/CacheDiskStaticUtils;->getSerializable(Ljava/lang/String;Ljava/lang/Object;Lcom/blankj/utilcode/util/CacheDiskUtils;)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public static getSerializable(Ljava/lang/String;Ljava/lang/Object;Lcom/blankj/utilcode/util/CacheDiskUtils;)Ljava/lang/Object;
    .locals 1
    .param p0, "key"    # Ljava/lang/String;
    .param p1, "defaultValue"    # Ljava/lang/Object;
    .param p2, "cacheDiskUtils"    # Lcom/blankj/utilcode/util/CacheDiskUtils;

    .line 910
    invoke-virtual {p2, p0, p1}, Lcom/blankj/utilcode/util/CacheDiskUtils;->getSerializable(Ljava/lang/String;Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public static getString(Ljava/lang/String;)Ljava/lang/String;
    .locals 1
    .param p0, "key"    # Ljava/lang/String;

    .line 110
    invoke-static {}, Lcom/blankj/utilcode/util/CacheDiskStaticUtils;->getDefaultCacheDiskUtils()Lcom/blankj/utilcode/util/CacheDiskUtils;

    move-result-object v0

    invoke-static {p0, v0}, Lcom/blankj/utilcode/util/CacheDiskStaticUtils;->getString(Ljava/lang/String;Lcom/blankj/utilcode/util/CacheDiskUtils;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static getString(Ljava/lang/String;Lcom/blankj/utilcode/util/CacheDiskUtils;)Ljava/lang/String;
    .locals 1
    .param p0, "key"    # Ljava/lang/String;
    .param p1, "cacheDiskUtils"    # Lcom/blankj/utilcode/util/CacheDiskUtils;

    .line 545
    invoke-virtual {p1, p0}, Lcom/blankj/utilcode/util/CacheDiskUtils;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .locals 1
    .param p0, "key"    # Ljava/lang/String;
    .param p1, "defaultValue"    # Ljava/lang/String;

    .line 121
    invoke-static {}, Lcom/blankj/utilcode/util/CacheDiskStaticUtils;->getDefaultCacheDiskUtils()Lcom/blankj/utilcode/util/CacheDiskUtils;

    move-result-object v0

    invoke-static {p0, p1, v0}, Lcom/blankj/utilcode/util/CacheDiskStaticUtils;->getString(Ljava/lang/String;Ljava/lang/String;Lcom/blankj/utilcode/util/CacheDiskUtils;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static getString(Ljava/lang/String;Ljava/lang/String;Lcom/blankj/utilcode/util/CacheDiskUtils;)Ljava/lang/String;
    .locals 1
    .param p0, "key"    # Ljava/lang/String;
    .param p1, "defaultValue"    # Ljava/lang/String;
    .param p2, "cacheDiskUtils"    # Lcom/blankj/utilcode/util/CacheDiskUtils;

    .line 559
    invoke-virtual {p2, p0, p1}, Lcom/blankj/utilcode/util/CacheDiskUtils;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static put(Ljava/lang/String;Landroid/graphics/Bitmap;)V
    .locals 1
    .param p0, "key"    # Ljava/lang/String;
    .param p1, "value"    # Landroid/graphics/Bitmap;

    .line 231
    invoke-static {}, Lcom/blankj/utilcode/util/CacheDiskStaticUtils;->getDefaultCacheDiskUtils()Lcom/blankj/utilcode/util/CacheDiskUtils;

    move-result-object v0

    invoke-static {p0, p1, v0}, Lcom/blankj/utilcode/util/CacheDiskStaticUtils;->put(Ljava/lang/String;Landroid/graphics/Bitmap;Lcom/blankj/utilcode/util/CacheDiskUtils;)V

    .line 232
    return-void
.end method

.method public static put(Ljava/lang/String;Landroid/graphics/Bitmap;I)V
    .locals 1
    .param p0, "key"    # Ljava/lang/String;
    .param p1, "value"    # Landroid/graphics/Bitmap;
    .param p2, "saveTime"    # I

    .line 242
    invoke-static {}, Lcom/blankj/utilcode/util/CacheDiskStaticUtils;->getDefaultCacheDiskUtils()Lcom/blankj/utilcode/util/CacheDiskUtils;

    move-result-object v0

    invoke-static {p0, p1, p2, v0}, Lcom/blankj/utilcode/util/CacheDiskStaticUtils;->put(Ljava/lang/String;Landroid/graphics/Bitmap;ILcom/blankj/utilcode/util/CacheDiskUtils;)V

    .line 243
    return-void
.end method

.method public static put(Ljava/lang/String;Landroid/graphics/Bitmap;ILcom/blankj/utilcode/util/CacheDiskUtils;)V
    .locals 0
    .param p0, "key"    # Ljava/lang/String;
    .param p1, "value"    # Landroid/graphics/Bitmap;
    .param p2, "saveTime"    # I
    .param p3, "cacheDiskUtils"    # Lcom/blankj/utilcode/util/CacheDiskUtils;

    .line 707
    invoke-virtual {p3, p0, p1, p2}, Lcom/blankj/utilcode/util/CacheDiskUtils;->put(Ljava/lang/String;Landroid/graphics/Bitmap;I)V

    .line 708
    return-void
.end method

.method public static put(Ljava/lang/String;Landroid/graphics/Bitmap;Lcom/blankj/utilcode/util/CacheDiskUtils;)V
    .locals 0
    .param p0, "key"    # Ljava/lang/String;
    .param p1, "value"    # Landroid/graphics/Bitmap;
    .param p2, "cacheDiskUtils"    # Lcom/blankj/utilcode/util/CacheDiskUtils;

    .line 692
    invoke-virtual {p2, p0, p1}, Lcom/blankj/utilcode/util/CacheDiskUtils;->put(Ljava/lang/String;Landroid/graphics/Bitmap;)V

    .line 693
    return-void
.end method

.method public static put(Ljava/lang/String;Landroid/graphics/drawable/Drawable;)V
    .locals 1
    .param p0, "key"    # Ljava/lang/String;
    .param p1, "value"    # Landroid/graphics/drawable/Drawable;

    .line 277
    invoke-static {}, Lcom/blankj/utilcode/util/CacheDiskStaticUtils;->getDefaultCacheDiskUtils()Lcom/blankj/utilcode/util/CacheDiskUtils;

    move-result-object v0

    invoke-static {p0, p1, v0}, Lcom/blankj/utilcode/util/CacheDiskStaticUtils;->put(Ljava/lang/String;Landroid/graphics/drawable/Drawable;Lcom/blankj/utilcode/util/CacheDiskUtils;)V

    .line 278
    return-void
.end method

.method public static put(Ljava/lang/String;Landroid/graphics/drawable/Drawable;I)V
    .locals 1
    .param p0, "key"    # Ljava/lang/String;
    .param p1, "value"    # Landroid/graphics/drawable/Drawable;
    .param p2, "saveTime"    # I

    .line 288
    invoke-static {}, Lcom/blankj/utilcode/util/CacheDiskStaticUtils;->getDefaultCacheDiskUtils()Lcom/blankj/utilcode/util/CacheDiskUtils;

    move-result-object v0

    invoke-static {p0, p1, p2, v0}, Lcom/blankj/utilcode/util/CacheDiskStaticUtils;->put(Ljava/lang/String;Landroid/graphics/drawable/Drawable;ILcom/blankj/utilcode/util/CacheDiskUtils;)V

    .line 289
    return-void
.end method

.method public static put(Ljava/lang/String;Landroid/graphics/drawable/Drawable;ILcom/blankj/utilcode/util/CacheDiskUtils;)V
    .locals 0
    .param p0, "key"    # Ljava/lang/String;
    .param p1, "value"    # Landroid/graphics/drawable/Drawable;
    .param p2, "saveTime"    # I
    .param p3, "cacheDiskUtils"    # Lcom/blankj/utilcode/util/CacheDiskUtils;

    .line 764
    invoke-virtual {p3, p0, p1, p2}, Lcom/blankj/utilcode/util/CacheDiskUtils;->put(Ljava/lang/String;Landroid/graphics/drawable/Drawable;I)V

    .line 765
    return-void
.end method

.method public static put(Ljava/lang/String;Landroid/graphics/drawable/Drawable;Lcom/blankj/utilcode/util/CacheDiskUtils;)V
    .locals 0
    .param p0, "key"    # Ljava/lang/String;
    .param p1, "value"    # Landroid/graphics/drawable/Drawable;
    .param p2, "cacheDiskUtils"    # Lcom/blankj/utilcode/util/CacheDiskUtils;

    .line 749
    invoke-virtual {p2, p0, p1}, Lcom/blankj/utilcode/util/CacheDiskUtils;->put(Ljava/lang/String;Landroid/graphics/drawable/Drawable;)V

    .line 750
    return-void
.end method

.method public static put(Ljava/lang/String;Landroid/os/Parcelable;)V
    .locals 1
    .param p0, "key"    # Ljava/lang/String;
    .param p1, "value"    # Landroid/os/Parcelable;

    .line 323
    invoke-static {}, Lcom/blankj/utilcode/util/CacheDiskStaticUtils;->getDefaultCacheDiskUtils()Lcom/blankj/utilcode/util/CacheDiskUtils;

    move-result-object v0

    invoke-static {p0, p1, v0}, Lcom/blankj/utilcode/util/CacheDiskStaticUtils;->put(Ljava/lang/String;Landroid/os/Parcelable;Lcom/blankj/utilcode/util/CacheDiskUtils;)V

    .line 324
    return-void
.end method

.method public static put(Ljava/lang/String;Landroid/os/Parcelable;I)V
    .locals 1
    .param p0, "key"    # Ljava/lang/String;
    .param p1, "value"    # Landroid/os/Parcelable;
    .param p2, "saveTime"    # I

    .line 334
    invoke-static {}, Lcom/blankj/utilcode/util/CacheDiskStaticUtils;->getDefaultCacheDiskUtils()Lcom/blankj/utilcode/util/CacheDiskUtils;

    move-result-object v0

    invoke-static {p0, p1, p2, v0}, Lcom/blankj/utilcode/util/CacheDiskStaticUtils;->put(Ljava/lang/String;Landroid/os/Parcelable;ILcom/blankj/utilcode/util/CacheDiskUtils;)V

    .line 335
    return-void
.end method

.method public static put(Ljava/lang/String;Landroid/os/Parcelable;ILcom/blankj/utilcode/util/CacheDiskUtils;)V
    .locals 0
    .param p0, "key"    # Ljava/lang/String;
    .param p1, "value"    # Landroid/os/Parcelable;
    .param p2, "saveTime"    # I
    .param p3, "cacheDiskUtils"    # Lcom/blankj/utilcode/util/CacheDiskUtils;

    .line 821
    invoke-virtual {p3, p0, p1, p2}, Lcom/blankj/utilcode/util/CacheDiskUtils;->put(Ljava/lang/String;Landroid/os/Parcelable;I)V

    .line 822
    return-void
.end method

.method public static put(Ljava/lang/String;Landroid/os/Parcelable;Lcom/blankj/utilcode/util/CacheDiskUtils;)V
    .locals 0
    .param p0, "key"    # Ljava/lang/String;
    .param p1, "value"    # Landroid/os/Parcelable;
    .param p2, "cacheDiskUtils"    # Lcom/blankj/utilcode/util/CacheDiskUtils;

    .line 806
    invoke-virtual {p2, p0, p1}, Lcom/blankj/utilcode/util/CacheDiskUtils;->put(Ljava/lang/String;Landroid/os/Parcelable;)V

    .line 807
    return-void
.end method

.method public static put(Ljava/lang/String;Ljava/io/Serializable;)V
    .locals 1
    .param p0, "key"    # Ljava/lang/String;
    .param p1, "value"    # Ljava/io/Serializable;

    .line 376
    invoke-static {}, Lcom/blankj/utilcode/util/CacheDiskStaticUtils;->getDefaultCacheDiskUtils()Lcom/blankj/utilcode/util/CacheDiskUtils;

    move-result-object v0

    invoke-static {p0, p1, v0}, Lcom/blankj/utilcode/util/CacheDiskStaticUtils;->put(Ljava/lang/String;Ljava/io/Serializable;Lcom/blankj/utilcode/util/CacheDiskUtils;)V

    .line 377
    return-void
.end method

.method public static put(Ljava/lang/String;Ljava/io/Serializable;I)V
    .locals 1
    .param p0, "key"    # Ljava/lang/String;
    .param p1, "value"    # Ljava/io/Serializable;
    .param p2, "saveTime"    # I

    .line 387
    invoke-static {}, Lcom/blankj/utilcode/util/CacheDiskStaticUtils;->getDefaultCacheDiskUtils()Lcom/blankj/utilcode/util/CacheDiskUtils;

    move-result-object v0

    invoke-static {p0, p1, p2, v0}, Lcom/blankj/utilcode/util/CacheDiskStaticUtils;->put(Ljava/lang/String;Ljava/io/Serializable;ILcom/blankj/utilcode/util/CacheDiskUtils;)V

    .line 388
    return-void
.end method

.method public static put(Ljava/lang/String;Ljava/io/Serializable;ILcom/blankj/utilcode/util/CacheDiskUtils;)V
    .locals 0
    .param p0, "key"    # Ljava/lang/String;
    .param p1, "value"    # Ljava/io/Serializable;
    .param p2, "saveTime"    # I
    .param p3, "cacheDiskUtils"    # Lcom/blankj/utilcode/util/CacheDiskUtils;

    .line 885
    invoke-virtual {p3, p0, p1, p2}, Lcom/blankj/utilcode/util/CacheDiskUtils;->put(Ljava/lang/String;Ljava/io/Serializable;I)V

    .line 886
    return-void
.end method

.method public static put(Ljava/lang/String;Ljava/io/Serializable;Lcom/blankj/utilcode/util/CacheDiskUtils;)V
    .locals 0
    .param p0, "key"    # Ljava/lang/String;
    .param p1, "value"    # Ljava/io/Serializable;
    .param p2, "cacheDiskUtils"    # Lcom/blankj/utilcode/util/CacheDiskUtils;

    .line 870
    invoke-virtual {p2, p0, p1}, Lcom/blankj/utilcode/util/CacheDiskUtils;->put(Ljava/lang/String;Ljava/io/Serializable;)V

    .line 871
    return-void
.end method

.method public static put(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1
    .param p0, "key"    # Ljava/lang/String;
    .param p1, "value"    # Ljava/lang/String;

    .line 89
    invoke-static {}, Lcom/blankj/utilcode/util/CacheDiskStaticUtils;->getDefaultCacheDiskUtils()Lcom/blankj/utilcode/util/CacheDiskUtils;

    move-result-object v0

    invoke-static {p0, p1, v0}, Lcom/blankj/utilcode/util/CacheDiskStaticUtils;->put(Ljava/lang/String;Ljava/lang/String;Lcom/blankj/utilcode/util/CacheDiskUtils;)V

    .line 90
    return-void
.end method

.method public static put(Ljava/lang/String;Ljava/lang/String;I)V
    .locals 1
    .param p0, "key"    # Ljava/lang/String;
    .param p1, "value"    # Ljava/lang/String;
    .param p2, "saveTime"    # I

    .line 100
    invoke-static {}, Lcom/blankj/utilcode/util/CacheDiskStaticUtils;->getDefaultCacheDiskUtils()Lcom/blankj/utilcode/util/CacheDiskUtils;

    move-result-object v0

    invoke-static {p0, p1, p2, v0}, Lcom/blankj/utilcode/util/CacheDiskStaticUtils;->put(Ljava/lang/String;Ljava/lang/String;ILcom/blankj/utilcode/util/CacheDiskUtils;)V

    .line 101
    return-void
.end method

.method public static put(Ljava/lang/String;Ljava/lang/String;ILcom/blankj/utilcode/util/CacheDiskUtils;)V
    .locals 0
    .param p0, "key"    # Ljava/lang/String;
    .param p1, "value"    # Ljava/lang/String;
    .param p2, "saveTime"    # I
    .param p3, "cacheDiskUtils"    # Lcom/blankj/utilcode/util/CacheDiskUtils;

    .line 534
    invoke-virtual {p3, p0, p1, p2}, Lcom/blankj/utilcode/util/CacheDiskUtils;->put(Ljava/lang/String;Ljava/lang/String;I)V

    .line 535
    return-void
.end method

.method public static put(Ljava/lang/String;Ljava/lang/String;Lcom/blankj/utilcode/util/CacheDiskUtils;)V
    .locals 0
    .param p0, "key"    # Ljava/lang/String;
    .param p1, "value"    # Ljava/lang/String;
    .param p2, "cacheDiskUtils"    # Lcom/blankj/utilcode/util/CacheDiskUtils;

    .line 519
    invoke-virtual {p2, p0, p1}, Lcom/blankj/utilcode/util/CacheDiskUtils;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 520
    return-void
.end method

.method public static put(Ljava/lang/String;Lorg/json/JSONArray;)V
    .locals 1
    .param p0, "key"    # Ljava/lang/String;
    .param p1, "value"    # Lorg/json/JSONArray;

    .line 184
    invoke-static {}, Lcom/blankj/utilcode/util/CacheDiskStaticUtils;->getDefaultCacheDiskUtils()Lcom/blankj/utilcode/util/CacheDiskUtils;

    move-result-object v0

    invoke-static {p0, p1, v0}, Lcom/blankj/utilcode/util/CacheDiskStaticUtils;->put(Ljava/lang/String;Lorg/json/JSONArray;Lcom/blankj/utilcode/util/CacheDiskUtils;)V

    .line 185
    return-void
.end method

.method public static put(Ljava/lang/String;Lorg/json/JSONArray;I)V
    .locals 1
    .param p0, "key"    # Ljava/lang/String;
    .param p1, "value"    # Lorg/json/JSONArray;
    .param p2, "saveTime"    # I

    .line 195
    invoke-static {}, Lcom/blankj/utilcode/util/CacheDiskStaticUtils;->getDefaultCacheDiskUtils()Lcom/blankj/utilcode/util/CacheDiskUtils;

    move-result-object v0

    invoke-static {p0, p1, p2, v0}, Lcom/blankj/utilcode/util/CacheDiskStaticUtils;->put(Ljava/lang/String;Lorg/json/JSONArray;ILcom/blankj/utilcode/util/CacheDiskUtils;)V

    .line 196
    return-void
.end method

.method public static put(Ljava/lang/String;Lorg/json/JSONArray;ILcom/blankj/utilcode/util/CacheDiskUtils;)V
    .locals 0
    .param p0, "key"    # Ljava/lang/String;
    .param p1, "value"    # Lorg/json/JSONArray;
    .param p2, "saveTime"    # I
    .param p3, "cacheDiskUtils"    # Lcom/blankj/utilcode/util/CacheDiskUtils;

    .line 649
    invoke-virtual {p3, p0, p1, p2}, Lcom/blankj/utilcode/util/CacheDiskUtils;->put(Ljava/lang/String;Lorg/json/JSONArray;I)V

    .line 650
    return-void
.end method

.method public static put(Ljava/lang/String;Lorg/json/JSONArray;Lcom/blankj/utilcode/util/CacheDiskUtils;)V
    .locals 0
    .param p0, "key"    # Ljava/lang/String;
    .param p1, "value"    # Lorg/json/JSONArray;
    .param p2, "cacheDiskUtils"    # Lcom/blankj/utilcode/util/CacheDiskUtils;

    .line 634
    invoke-virtual {p2, p0, p1}, Lcom/blankj/utilcode/util/CacheDiskUtils;->put(Ljava/lang/String;Lorg/json/JSONArray;)V

    .line 635
    return-void
.end method

.method public static put(Ljava/lang/String;Lorg/json/JSONObject;)V
    .locals 1
    .param p0, "key"    # Ljava/lang/String;
    .param p1, "value"    # Lorg/json/JSONObject;

    .line 135
    invoke-static {}, Lcom/blankj/utilcode/util/CacheDiskStaticUtils;->getDefaultCacheDiskUtils()Lcom/blankj/utilcode/util/CacheDiskUtils;

    move-result-object v0

    invoke-static {p0, p1, v0}, Lcom/blankj/utilcode/util/CacheDiskStaticUtils;->put(Ljava/lang/String;Lorg/json/JSONObject;Lcom/blankj/utilcode/util/CacheDiskUtils;)V

    .line 136
    return-void
.end method

.method public static put(Ljava/lang/String;Lorg/json/JSONObject;I)V
    .locals 1
    .param p0, "key"    # Ljava/lang/String;
    .param p1, "value"    # Lorg/json/JSONObject;
    .param p2, "saveTime"    # I

    .line 148
    invoke-static {}, Lcom/blankj/utilcode/util/CacheDiskStaticUtils;->getDefaultCacheDiskUtils()Lcom/blankj/utilcode/util/CacheDiskUtils;

    move-result-object v0

    invoke-static {p0, p1, p2, v0}, Lcom/blankj/utilcode/util/CacheDiskStaticUtils;->put(Ljava/lang/String;Lorg/json/JSONObject;ILcom/blankj/utilcode/util/CacheDiskUtils;)V

    .line 149
    return-void
.end method

.method public static put(Ljava/lang/String;Lorg/json/JSONObject;ILcom/blankj/utilcode/util/CacheDiskUtils;)V
    .locals 0
    .param p0, "key"    # Ljava/lang/String;
    .param p1, "value"    # Lorg/json/JSONObject;
    .param p2, "saveTime"    # I
    .param p3, "cacheDiskUtils"    # Lcom/blankj/utilcode/util/CacheDiskUtils;

    .line 591
    invoke-virtual {p3, p0, p1, p2}, Lcom/blankj/utilcode/util/CacheDiskUtils;->put(Ljava/lang/String;Lorg/json/JSONObject;I)V

    .line 592
    return-void
.end method

.method public static put(Ljava/lang/String;Lorg/json/JSONObject;Lcom/blankj/utilcode/util/CacheDiskUtils;)V
    .locals 0
    .param p0, "key"    # Ljava/lang/String;
    .param p1, "value"    # Lorg/json/JSONObject;
    .param p2, "cacheDiskUtils"    # Lcom/blankj/utilcode/util/CacheDiskUtils;

    .line 576
    invoke-virtual {p2, p0, p1}, Lcom/blankj/utilcode/util/CacheDiskUtils;->put(Ljava/lang/String;Lorg/json/JSONObject;)V

    .line 577
    return-void
.end method

.method public static put(Ljava/lang/String;[B)V
    .locals 1
    .param p0, "key"    # Ljava/lang/String;
    .param p1, "value"    # [B

    .line 43
    invoke-static {}, Lcom/blankj/utilcode/util/CacheDiskStaticUtils;->getDefaultCacheDiskUtils()Lcom/blankj/utilcode/util/CacheDiskUtils;

    move-result-object v0

    invoke-static {p0, p1, v0}, Lcom/blankj/utilcode/util/CacheDiskStaticUtils;->put(Ljava/lang/String;[BLcom/blankj/utilcode/util/CacheDiskUtils;)V

    .line 44
    return-void
.end method

.method public static put(Ljava/lang/String;[BI)V
    .locals 1
    .param p0, "key"    # Ljava/lang/String;
    .param p1, "value"    # [B
    .param p2, "saveTime"    # I

    .line 54
    invoke-static {}, Lcom/blankj/utilcode/util/CacheDiskStaticUtils;->getDefaultCacheDiskUtils()Lcom/blankj/utilcode/util/CacheDiskUtils;

    move-result-object v0

    invoke-static {p0, p1, p2, v0}, Lcom/blankj/utilcode/util/CacheDiskStaticUtils;->put(Ljava/lang/String;[BILcom/blankj/utilcode/util/CacheDiskUtils;)V

    .line 55
    return-void
.end method

.method public static put(Ljava/lang/String;[BILcom/blankj/utilcode/util/CacheDiskUtils;)V
    .locals 0
    .param p0, "key"    # Ljava/lang/String;
    .param p1, "value"    # [B
    .param p2, "saveTime"    # I
    .param p3, "cacheDiskUtils"    # Lcom/blankj/utilcode/util/CacheDiskUtils;

    .line 477
    invoke-virtual {p3, p0, p1, p2}, Lcom/blankj/utilcode/util/CacheDiskUtils;->put(Ljava/lang/String;[BI)V

    .line 478
    return-void
.end method

.method public static put(Ljava/lang/String;[BLcom/blankj/utilcode/util/CacheDiskUtils;)V
    .locals 0
    .param p0, "key"    # Ljava/lang/String;
    .param p1, "value"    # [B
    .param p2, "cacheDiskUtils"    # Lcom/blankj/utilcode/util/CacheDiskUtils;

    .line 462
    invoke-virtual {p2, p0, p1}, Lcom/blankj/utilcode/util/CacheDiskUtils;->put(Ljava/lang/String;[B)V

    .line 463
    return-void
.end method

.method public static remove(Ljava/lang/String;)Z
    .locals 1
    .param p0, "key"    # Ljava/lang/String;

    .line 436
    invoke-static {}, Lcom/blankj/utilcode/util/CacheDiskStaticUtils;->getDefaultCacheDiskUtils()Lcom/blankj/utilcode/util/CacheDiskUtils;

    move-result-object v0

    invoke-static {p0, v0}, Lcom/blankj/utilcode/util/CacheDiskStaticUtils;->remove(Ljava/lang/String;Lcom/blankj/utilcode/util/CacheDiskUtils;)Z

    move-result v0

    return v0
.end method

.method public static remove(Ljava/lang/String;Lcom/blankj/utilcode/util/CacheDiskUtils;)Z
    .locals 1
    .param p0, "key"    # Ljava/lang/String;
    .param p1, "cacheDiskUtils"    # Lcom/blankj/utilcode/util/CacheDiskUtils;

    .line 941
    invoke-virtual {p1, p0}, Lcom/blankj/utilcode/util/CacheDiskUtils;->remove(Ljava/lang/String;)Z

    move-result v0

    return v0
.end method

.method public static setDefaultCacheDiskUtils(Lcom/blankj/utilcode/util/CacheDiskUtils;)V
    .locals 0
    .param p0, "cacheDiskUtils"    # Lcom/blankj/utilcode/util/CacheDiskUtils;

    .line 33
    sput-object p0, Lcom/blankj/utilcode/util/CacheDiskStaticUtils;->sDefaultCacheDiskUtils:Lcom/blankj/utilcode/util/CacheDiskUtils;

    .line 34
    return-void
.end method
