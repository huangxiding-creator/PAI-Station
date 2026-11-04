.class Lorg/simpleframework/xml/core/SignatureBuilder$ParameterTable;
.super Ljava/util/ArrayList;
.source "SignatureBuilder.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lorg/simpleframework/xml/core/SignatureBuilder;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0xa
    name = "ParameterTable"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/util/ArrayList<",
        "Lorg/simpleframework/xml/core/SignatureBuilder$ParameterList;",
        ">;"
    }
.end annotation


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 257
    invoke-direct {p0}, Ljava/util/ArrayList;-><init>()V

    .line 258
    return-void
.end method

.method static synthetic access$000(Lorg/simpleframework/xml/core/SignatureBuilder$ParameterTable;)I
    .locals 1
    .param p0, "x0"    # Lorg/simpleframework/xml/core/SignatureBuilder$ParameterTable;

    .line 249
    invoke-direct {p0}, Lorg/simpleframework/xml/core/SignatureBuilder$ParameterTable;->width()I

    move-result v0

    return v0
.end method

.method static synthetic access$100(Lorg/simpleframework/xml/core/SignatureBuilder$ParameterTable;)I
    .locals 1
    .param p0, "x0"    # Lorg/simpleframework/xml/core/SignatureBuilder$ParameterTable;

    .line 249
    invoke-direct {p0}, Lorg/simpleframework/xml/core/SignatureBuilder$ParameterTable;->height()I

    move-result v0

    return v0
.end method

.method private height()I
    .locals 2

    .line 268
    invoke-direct {p0}, Lorg/simpleframework/xml/core/SignatureBuilder$ParameterTable;->width()I

    move-result v0

    .line 270
    .local v0, "width":I
    const/4 v1, 0x0

    if-lez v0, :cond_0

    .line 271
    invoke-virtual {p0, v1}, Lorg/simpleframework/xml/core/SignatureBuilder$ParameterTable;->get(I)Lorg/simpleframework/xml/core/SignatureBuilder$ParameterList;

    move-result-object v1

    invoke-virtual {v1}, Lorg/simpleframework/xml/core/SignatureBuilder$ParameterList;->size()I

    move-result v1

    return v1

    .line 273
    :cond_0
    return v1
.end method

.method private width()I
    .locals 1

    .line 284
    invoke-virtual {p0}, Lorg/simpleframework/xml/core/SignatureBuilder$ParameterTable;->size()I

    move-result v0

    return v0
.end method


# virtual methods
.method public bridge synthetic get(I)Ljava/lang/Object;
    .locals 0

    .line 249
    invoke-virtual {p0, p1}, Lorg/simpleframework/xml/core/SignatureBuilder$ParameterTable;->get(I)Lorg/simpleframework/xml/core/SignatureBuilder$ParameterList;

    move-result-object p1

    return-object p1
.end method

.method public get(II)Lorg/simpleframework/xml/core/Parameter;
    .locals 1
    .param p1, "column"    # I
    .param p2, "row"    # I

    .line 333
    invoke-virtual {p0, p1}, Lorg/simpleframework/xml/core/SignatureBuilder$ParameterTable;->get(I)Lorg/simpleframework/xml/core/SignatureBuilder$ParameterList;

    move-result-object v0

    invoke-virtual {v0, p2}, Lorg/simpleframework/xml/core/SignatureBuilder$ParameterList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lorg/simpleframework/xml/core/Parameter;

    return-object v0
.end method

.method public get(I)Lorg/simpleframework/xml/core/SignatureBuilder$ParameterList;
    .locals 3
    .param p1, "column"    # I

    .line 313
    invoke-virtual {p0}, Lorg/simpleframework/xml/core/SignatureBuilder$ParameterTable;->size()I

    move-result v0

    .line 315
    .local v0, "size":I
    move v1, v0

    .local v1, "i":I
    :goto_0
    if-gt v1, p1, :cond_0

    .line 316
    new-instance v2, Lorg/simpleframework/xml/core/SignatureBuilder$ParameterList;

    invoke-direct {v2}, Lorg/simpleframework/xml/core/SignatureBuilder$ParameterList;-><init>()V

    .line 317
    .local v2, "list":Lorg/simpleframework/xml/core/SignatureBuilder$ParameterList;
    invoke-virtual {p0, v2}, Lorg/simpleframework/xml/core/SignatureBuilder$ParameterTable;->add(Ljava/lang/Object;)Z

    .line 315
    .end local v2    # "list":Lorg/simpleframework/xml/core/SignatureBuilder$ParameterList;
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 319
    .end local v1    # "i":I
    :cond_0
    invoke-super {p0, p1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lorg/simpleframework/xml/core/SignatureBuilder$ParameterList;

    return-object v1
.end method

.method public insert(Lorg/simpleframework/xml/core/Parameter;I)V
    .locals 1
    .param p1, "value"    # Lorg/simpleframework/xml/core/Parameter;
    .param p2, "column"    # I

    .line 296
    invoke-virtual {p0, p2}, Lorg/simpleframework/xml/core/SignatureBuilder$ParameterTable;->get(I)Lorg/simpleframework/xml/core/SignatureBuilder$ParameterList;

    move-result-object v0

    .line 298
    .local v0, "list":Lorg/simpleframework/xml/core/SignatureBuilder$ParameterList;
    if-eqz v0, :cond_0

    .line 299
    invoke-virtual {v0, p1}, Lorg/simpleframework/xml/core/SignatureBuilder$ParameterList;->add(Ljava/lang/Object;)Z

    .line 301
    :cond_0
    return-void
.end method
