.class public Lcom/rokid/utils/PropertiesUtils;
.super Ljava/lang/Object;
.source "PropertiesUtils.java"


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 13
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static getProperties(Landroid/content/Context;Ljava/lang/String;)Ljava/util/Properties;
    .locals 2
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "assetsName"    # Ljava/lang/String;

    .line 15
    new-instance v0, Ljava/util/Properties;

    invoke-direct {v0}, Ljava/util/Properties;-><init>()V

    .line 17
    .local v0, "properties":Ljava/util/Properties;
    :try_start_0
    invoke-virtual {p0}, Landroid/content/Context;->getAssets()Landroid/content/res/AssetManager;

    move-result-object v1

    invoke-virtual {v1, p1}, Landroid/content/res/AssetManager;->open(Ljava/lang/String;)Ljava/io/InputStream;

    move-result-object v1

    .line 18
    .local v1, "in":Ljava/io/InputStream;
    invoke-virtual {v0, v1}, Ljava/util/Properties;->load(Ljava/io/InputStream;)V

    .line 19
    invoke-virtual {v1}, Ljava/io/InputStream;->close()V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 22
    .end local v1    # "in":Ljava/io/InputStream;
    goto :goto_0

    .line 20
    :catch_0
    move-exception v1

    .line 21
    .local v1, "e":Ljava/io/IOException;
    invoke-virtual {v1}, Ljava/io/IOException;->printStackTrace()V

    .line 23
    .end local v1    # "e":Ljava/io/IOException;
    :goto_0
    return-object v0
.end method
