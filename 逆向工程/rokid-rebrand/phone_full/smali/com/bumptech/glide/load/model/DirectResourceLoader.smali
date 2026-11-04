.class public final Lcom/bumptech/glide/load/model/DirectResourceLoader;
.super Ljava/lang/Object;
.source "DirectResourceLoader.java"

# interfaces
.implements Lcom/bumptech/glide/load/model/ModelLoader;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/bumptech/glide/load/model/DirectResourceLoader$InputStreamFactory;,
        Lcom/bumptech/glide/load/model/DirectResourceLoader$AssetFileDescriptorFactory;,
        Lcom/bumptech/glide/load/model/DirectResourceLoader$DrawableFactory;,
        Lcom/bumptech/glide/load/model/DirectResourceLoader$ResourceOpener;,
        Lcom/bumptech/glide/load/model/DirectResourceLoader$ResourceDataFetcher;
    }
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "<DataT:",
        "Ljava/lang/Object;",
        ">",
        "Ljava/lang/Object;",
        "Lcom/bumptech/glide/load/model/ModelLoader<",
        "Ljava/lang/Integer;",
        "TDataT;>;"
    }
.end annotation


# instance fields
.field private final context:Landroid/content/Context;

.field private final resourceOpener:Lcom/bumptech/glide/load/model/DirectResourceLoader$ResourceOpener;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lcom/bumptech/glide/load/model/DirectResourceLoader$ResourceOpener<",
            "TDataT;>;"
        }
    .end annotation
.end field


# direct methods
.method constructor <init>(Landroid/content/Context;Lcom/bumptech/glide/load/model/DirectResourceLoader$ResourceOpener;)V
    .locals 1
    .param p1, "context"    # Landroid/content/Context;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            "Lcom/bumptech/glide/load/model/DirectResourceLoader$ResourceOpener<",
            "TDataT;>;)V"
        }
    .end annotation

    .line 52
    .local p0, "this":Lcom/bumptech/glide/load/model/DirectResourceLoader;, "Lcom/bumptech/glide/load/model/DirectResourceLoader<TDataT;>;"
    .local p2, "resourceOpener":Lcom/bumptech/glide/load/model/DirectResourceLoader$ResourceOpener;, "Lcom/bumptech/glide/load/model/DirectResourceLoader$ResourceOpener<TDataT;>;"
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 53
    invoke-virtual {p1}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    iput-object v0, p0, Lcom/bumptech/glide/load/model/DirectResourceLoader;->context:Landroid/content/Context;

    .line 54
    iput-object p2, p0, Lcom/bumptech/glide/load/model/DirectResourceLoader;->resourceOpener:Lcom/bumptech/glide/load/model/DirectResourceLoader$ResourceOpener;

    .line 55
    return-void
.end method

.method public static assetFileDescriptorFactory(Landroid/content/Context;)Lcom/bumptech/glide/load/model/ModelLoaderFactory;
    .locals 1
    .param p0, "context"    # Landroid/content/Context;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            ")",
            "Lcom/bumptech/glide/load/model/ModelLoaderFactory<",
            "Ljava/lang/Integer;",
            "Landroid/content/res/AssetFileDescriptor;",
            ">;"
        }
    .end annotation

    .line 45
    new-instance v0, Lcom/bumptech/glide/load/model/DirectResourceLoader$AssetFileDescriptorFactory;

    invoke-direct {v0, p0}, Lcom/bumptech/glide/load/model/DirectResourceLoader$AssetFileDescriptorFactory;-><init>(Landroid/content/Context;)V

    return-object v0
.end method

.method public static drawableFactory(Landroid/content/Context;)Lcom/bumptech/glide/load/model/ModelLoaderFactory;
    .locals 1
    .param p0, "context"    # Landroid/content/Context;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            ")",
            "Lcom/bumptech/glide/load/model/ModelLoaderFactory<",
            "Ljava/lang/Integer;",
            "Landroid/graphics/drawable/Drawable;",
            ">;"
        }
    .end annotation

    .line 49
    new-instance v0, Lcom/bumptech/glide/load/model/DirectResourceLoader$DrawableFactory;

    invoke-direct {v0, p0}, Lcom/bumptech/glide/load/model/DirectResourceLoader$DrawableFactory;-><init>(Landroid/content/Context;)V

    return-object v0
.end method

.method public static inputStreamFactory(Landroid/content/Context;)Lcom/bumptech/glide/load/model/ModelLoaderFactory;
    .locals 1
    .param p0, "context"    # Landroid/content/Context;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            ")",
            "Lcom/bumptech/glide/load/model/ModelLoaderFactory<",
            "Ljava/lang/Integer;",
            "Ljava/io/InputStream;",
            ">;"
        }
    .end annotation

    .line 40
    new-instance v0, Lcom/bumptech/glide/load/model/DirectResourceLoader$InputStreamFactory;

    invoke-direct {v0, p0}, Lcom/bumptech/glide/load/model/DirectResourceLoader$InputStreamFactory;-><init>(Landroid/content/Context;)V

    return-object v0
.end method


# virtual methods
.method public buildLoadData(Ljava/lang/Integer;IILcom/bumptech/glide/load/Options;)Lcom/bumptech/glide/load/model/ModelLoader$LoadData;
    .locals 7
    .param p1, "resourceId"    # Ljava/lang/Integer;
    .param p2, "width"    # I
    .param p3, "height"    # I
    .param p4, "options"    # Lcom/bumptech/glide/load/Options;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Integer;",
            "II",
            "Lcom/bumptech/glide/load/Options;",
            ")",
            "Lcom/bumptech/glide/load/model/ModelLoader$LoadData<",
            "TDataT;>;"
        }
    .end annotation

    .line 60
    .local p0, "this":Lcom/bumptech/glide/load/model/DirectResourceLoader;, "Lcom/bumptech/glide/load/model/DirectResourceLoader<TDataT;>;"
    sget-object v0, Lcom/bumptech/glide/load/resource/drawable/ResourceDrawableDecoder;->THEME:Lcom/bumptech/glide/load/Option;

    invoke-virtual {p4, v0}, Lcom/bumptech/glide/load/Options;->get(Lcom/bumptech/glide/load/Option;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/content/res/Resources$Theme;

    .line 62
    .local v0, "theme":Landroid/content/res/Resources$Theme;
    if-eqz v0, :cond_0

    .line 63
    invoke-virtual {v0}, Landroid/content/res/Resources$Theme;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    goto :goto_0

    .line 64
    :cond_0
    iget-object v1, p0, Lcom/bumptech/glide/load/model/DirectResourceLoader;->context:Landroid/content/Context;

    invoke-virtual {v1}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    :goto_0
    nop

    .line 65
    .local v1, "resources":Landroid/content/res/Resources;
    new-instance v2, Lcom/bumptech/glide/load/model/ModelLoader$LoadData;

    new-instance v3, Lcom/bumptech/glide/signature/ObjectKey;

    invoke-direct {v3, p1}, Lcom/bumptech/glide/signature/ObjectKey;-><init>(Ljava/lang/Object;)V

    new-instance v4, Lcom/bumptech/glide/load/model/DirectResourceLoader$ResourceDataFetcher;

    iget-object v5, p0, Lcom/bumptech/glide/load/model/DirectResourceLoader;->resourceOpener:Lcom/bumptech/glide/load/model/DirectResourceLoader$ResourceOpener;

    .line 69
    invoke-virtual {p1}, Ljava/lang/Integer;->intValue()I

    move-result v6

    invoke-direct {v4, v0, v1, v5, v6}, Lcom/bumptech/glide/load/model/DirectResourceLoader$ResourceDataFetcher;-><init>(Landroid/content/res/Resources$Theme;Landroid/content/res/Resources;Lcom/bumptech/glide/load/model/DirectResourceLoader$ResourceOpener;I)V

    invoke-direct {v2, v3, v4}, Lcom/bumptech/glide/load/model/ModelLoader$LoadData;-><init>(Lcom/bumptech/glide/load/Key;Lcom/bumptech/glide/load/data/DataFetcher;)V

    .line 65
    return-object v2
.end method

.method public bridge synthetic buildLoadData(Ljava/lang/Object;IILcom/bumptech/glide/load/Options;)Lcom/bumptech/glide/load/model/ModelLoader$LoadData;
    .locals 0

    .line 34
    .local p0, "this":Lcom/bumptech/glide/load/model/DirectResourceLoader;, "Lcom/bumptech/glide/load/model/DirectResourceLoader<TDataT;>;"
    check-cast p1, Ljava/lang/Integer;

    invoke-virtual {p0, p1, p2, p3, p4}, Lcom/bumptech/glide/load/model/DirectResourceLoader;->buildLoadData(Ljava/lang/Integer;IILcom/bumptech/glide/load/Options;)Lcom/bumptech/glide/load/model/ModelLoader$LoadData;

    move-result-object p1

    return-object p1
.end method

.method public handles(Ljava/lang/Integer;)Z
    .locals 1
    .param p1, "integer"    # Ljava/lang/Integer;

    .line 76
    .local p0, "this":Lcom/bumptech/glide/load/model/DirectResourceLoader;, "Lcom/bumptech/glide/load/model/DirectResourceLoader<TDataT;>;"
    const/4 v0, 0x1

    return v0
.end method

.method public bridge synthetic handles(Ljava/lang/Object;)Z
    .locals 0

    .line 34
    .local p0, "this":Lcom/bumptech/glide/load/model/DirectResourceLoader;, "Lcom/bumptech/glide/load/model/DirectResourceLoader<TDataT;>;"
    check-cast p1, Ljava/lang/Integer;

    invoke-virtual {p0, p1}, Lcom/bumptech/glide/load/model/DirectResourceLoader;->handles(Ljava/lang/Integer;)Z

    move-result p1

    return p1
.end method
