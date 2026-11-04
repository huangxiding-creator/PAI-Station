.class public final Lcom/rokid/security/sdk/ability/param/ProductIdentifyResponse;
.super Ljava/lang/Object;
.source "AiChatParam.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u00000\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0000\n\u0002\u0010\u000e\n\u0002\u0008\u0003\n\u0002\u0010\u0008\n\u0000\n\u0002\u0010\t\n\u0002\u0008\u0005\n\u0002\u0010\u0006\n\u0002\u0008$\n\u0002\u0010\u000b\n\u0002\u0008\u0004\u0008\u0086\u0008\u0018\u00002\u00020\u0001Bm\u0012\u0006\u0010\u0002\u001a\u00020\u0003\u0012\u0006\u0010\u0004\u001a\u00020\u0003\u0012\u0006\u0010\u0005\u001a\u00020\u0003\u0012\u0006\u0010\u0006\u001a\u00020\u0007\u0012\u0006\u0010\u0008\u001a\u00020\t\u0012\u0006\u0010\n\u001a\u00020\t\u0012\u0006\u0010\u000b\u001a\u00020\u0007\u0012\u0006\u0010\u000c\u001a\u00020\u0003\u0012\u0006\u0010\r\u001a\u00020\u0003\u0012\u0006\u0010\u000e\u001a\u00020\u000f\u0012\u0006\u0010\u0010\u001a\u00020\u0003\u0012\u0006\u0010\u0011\u001a\u00020\u0003\u0012\u0006\u0010\u0012\u001a\u00020\u0003\u00a2\u0006\u0002\u0010\u0013J\t\u0010%\u001a\u00020\u0003H\u00c6\u0003J\t\u0010&\u001a\u00020\u000fH\u00c6\u0003J\t\u0010\'\u001a\u00020\u0003H\u00c6\u0003J\t\u0010(\u001a\u00020\u0003H\u00c6\u0003J\t\u0010)\u001a\u00020\u0003H\u00c6\u0003J\t\u0010*\u001a\u00020\u0003H\u00c6\u0003J\t\u0010+\u001a\u00020\u0003H\u00c6\u0003J\t\u0010,\u001a\u00020\u0007H\u00c6\u0003J\t\u0010-\u001a\u00020\tH\u00c6\u0003J\t\u0010.\u001a\u00020\tH\u00c6\u0003J\t\u0010/\u001a\u00020\u0007H\u00c6\u0003J\t\u00100\u001a\u00020\u0003H\u00c6\u0003J\t\u00101\u001a\u00020\u0003H\u00c6\u0003J\u008b\u0001\u00102\u001a\u00020\u00002\u0008\u0008\u0002\u0010\u0002\u001a\u00020\u00032\u0008\u0008\u0002\u0010\u0004\u001a\u00020\u00032\u0008\u0008\u0002\u0010\u0005\u001a\u00020\u00032\u0008\u0008\u0002\u0010\u0006\u001a\u00020\u00072\u0008\u0008\u0002\u0010\u0008\u001a\u00020\t2\u0008\u0008\u0002\u0010\n\u001a\u00020\t2\u0008\u0008\u0002\u0010\u000b\u001a\u00020\u00072\u0008\u0008\u0002\u0010\u000c\u001a\u00020\u00032\u0008\u0008\u0002\u0010\r\u001a\u00020\u00032\u0008\u0008\u0002\u0010\u000e\u001a\u00020\u000f2\u0008\u0008\u0002\u0010\u0010\u001a\u00020\u00032\u0008\u0008\u0002\u0010\u0011\u001a\u00020\u00032\u0008\u0008\u0002\u0010\u0012\u001a\u00020\u0003H\u00c6\u0001J\u0013\u00103\u001a\u0002042\u0008\u00105\u001a\u0004\u0018\u00010\u0001H\u00d6\u0003J\t\u00106\u001a\u00020\u0007H\u00d6\u0001J\t\u00107\u001a\u00020\u0003H\u00d6\u0001R\u0011\u0010\u0002\u001a\u00020\u0003\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\u0014\u0010\u0015R\u0011\u0010\u0004\u001a\u00020\u0003\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\u0016\u0010\u0015R\u0011\u0010\u0005\u001a\u00020\u0003\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\u0017\u0010\u0015R\u0011\u0010\u0006\u001a\u00020\u0007\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\u0018\u0010\u0019R\u0011\u0010\u0008\u001a\u00020\t\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\u001a\u0010\u001bR\u0011\u0010\n\u001a\u00020\t\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\u001c\u0010\u001bR\u0011\u0010\u000b\u001a\u00020\u0007\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\u001d\u0010\u0019R\u0011\u0010\u000c\u001a\u00020\u0003\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\u001e\u0010\u0015R\u0011\u0010\r\u001a\u00020\u0003\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\u001f\u0010\u0015R\u0011\u0010\u000e\u001a\u00020\u000f\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008 \u0010!R\u0011\u0010\u0010\u001a\u00020\u0003\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\"\u0010\u0015R\u0011\u0010\u0011\u001a\u00020\u0003\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008#\u0010\u0015R\u0011\u0010\u0012\u001a\u00020\u0003\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008$\u0010\u0015\u00a8\u00068"
    }
    d2 = {
        "Lcom/rokid/security/sdk/ability/param/ProductIdentifyResponse;",
        "",
        "barcode",
        "",
        "brand",
        "categoryCode",
        "deleted",
        "",
        "gmtCreated",
        "",
        "gmtModified",
        "id",
        "itemCategory",
        "name",
        "price",
        "",
        "specifications",
        "subItemCategory",
        "unit",
        "(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;IJJILjava/lang/String;Ljava/lang/String;DLjava/lang/String;Ljava/lang/String;Ljava/lang/String;)V",
        "getBarcode",
        "()Ljava/lang/String;",
        "getBrand",
        "getCategoryCode",
        "getDeleted",
        "()I",
        "getGmtCreated",
        "()J",
        "getGmtModified",
        "getId",
        "getItemCategory",
        "getName",
        "getPrice",
        "()D",
        "getSpecifications",
        "getSubItemCategory",
        "getUnit",
        "component1",
        "component10",
        "component11",
        "component12",
        "component13",
        "component2",
        "component3",
        "component4",
        "component5",
        "component6",
        "component7",
        "component8",
        "component9",
        "copy",
        "equals",
        "",
        "other",
        "hashCode",
        "toString",
        "sdk-common-ability_release"
    }
    k = 0x1
    mv = {
        0x1,
        0x8,
        0x0
    }
    xi = 0x30
.end annotation


# instance fields
.field private final barcode:Ljava/lang/String;

.field private final brand:Ljava/lang/String;

.field private final categoryCode:Ljava/lang/String;

.field private final deleted:I

.field private final gmtCreated:J

.field private final gmtModified:J

.field private final id:I

.field private final itemCategory:Ljava/lang/String;

.field private final name:Ljava/lang/String;

.field private final price:D

.field private final specifications:Ljava/lang/String;

.field private final subItemCategory:Ljava/lang/String;

.field private final unit:Ljava/lang/String;


# direct methods
.method public constructor <init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;IJJILjava/lang/String;Ljava/lang/String;DLjava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 15
    .param p1, "barcode"    # Ljava/lang/String;
    .param p2, "brand"    # Ljava/lang/String;
    .param p3, "categoryCode"    # Ljava/lang/String;
    .param p4, "deleted"    # I
    .param p5, "gmtCreated"    # J
    .param p7, "gmtModified"    # J
    .param p9, "id"    # I
    .param p10, "itemCategory"    # Ljava/lang/String;
    .param p11, "name"    # Ljava/lang/String;
    .param p12, "price"    # D
    .param p14, "specifications"    # Ljava/lang/String;
    .param p15, "subItemCategory"    # Ljava/lang/String;
    .param p16, "unit"    # Ljava/lang/String;

    move-object v0, p0

    move-object/from16 v1, p1

    move-object/from16 v2, p2

    move-object/from16 v3, p3

    move-object/from16 v4, p10

    move-object/from16 v5, p11

    move-object/from16 v6, p14

    move-object/from16 v7, p15

    move-object/from16 v8, p16

    const-string v9, "barcode"

    invoke-static {v1, v9}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v9, "brand"

    invoke-static {v2, v9}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v9, "categoryCode"

    invoke-static {v3, v9}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v9, "itemCategory"

    invoke-static {v4, v9}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v9, "name"

    invoke-static {v5, v9}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string/jumbo v9, "specifications"

    invoke-static {v6, v9}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string/jumbo v9, "subItemCategory"

    invoke-static {v7, v9}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string/jumbo v9, "unit"

    invoke-static {v8, v9}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 95
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 96
    iput-object v1, v0, Lcom/rokid/security/sdk/ability/param/ProductIdentifyResponse;->barcode:Ljava/lang/String;

    .line 97
    iput-object v2, v0, Lcom/rokid/security/sdk/ability/param/ProductIdentifyResponse;->brand:Ljava/lang/String;

    .line 98
    iput-object v3, v0, Lcom/rokid/security/sdk/ability/param/ProductIdentifyResponse;->categoryCode:Ljava/lang/String;

    .line 99
    move/from16 v9, p4

    iput v9, v0, Lcom/rokid/security/sdk/ability/param/ProductIdentifyResponse;->deleted:I

    .line 100
    move-wide/from16 v10, p5

    iput-wide v10, v0, Lcom/rokid/security/sdk/ability/param/ProductIdentifyResponse;->gmtCreated:J

    .line 101
    move-wide/from16 v12, p7

    iput-wide v12, v0, Lcom/rokid/security/sdk/ability/param/ProductIdentifyResponse;->gmtModified:J

    .line 102
    move/from16 v14, p9

    iput v14, v0, Lcom/rokid/security/sdk/ability/param/ProductIdentifyResponse;->id:I

    .line 103
    iput-object v4, v0, Lcom/rokid/security/sdk/ability/param/ProductIdentifyResponse;->itemCategory:Ljava/lang/String;

    .line 104
    iput-object v5, v0, Lcom/rokid/security/sdk/ability/param/ProductIdentifyResponse;->name:Ljava/lang/String;

    .line 105
    move-wide/from16 v1, p12

    iput-wide v1, v0, Lcom/rokid/security/sdk/ability/param/ProductIdentifyResponse;->price:D

    .line 106
    iput-object v6, v0, Lcom/rokid/security/sdk/ability/param/ProductIdentifyResponse;->specifications:Ljava/lang/String;

    .line 107
    iput-object v7, v0, Lcom/rokid/security/sdk/ability/param/ProductIdentifyResponse;->subItemCategory:Ljava/lang/String;

    .line 108
    iput-object v8, v0, Lcom/rokid/security/sdk/ability/param/ProductIdentifyResponse;->unit:Ljava/lang/String;

    .line 95
    return-void
.end method

.method public static synthetic copy$default(Lcom/rokid/security/sdk/ability/param/ProductIdentifyResponse;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;IJJILjava/lang/String;Ljava/lang/String;DLjava/lang/String;Ljava/lang/String;Ljava/lang/String;ILjava/lang/Object;)Lcom/rokid/security/sdk/ability/param/ProductIdentifyResponse;
    .locals 16

    move-object/from16 v0, p0

    move/from16 v1, p17

    and-int/lit8 v2, v1, 0x1

    if-eqz v2, :cond_0

    iget-object v2, v0, Lcom/rokid/security/sdk/ability/param/ProductIdentifyResponse;->barcode:Ljava/lang/String;

    goto :goto_0

    :cond_0
    move-object/from16 v2, p1

    :goto_0
    and-int/lit8 v3, v1, 0x2

    if-eqz v3, :cond_1

    iget-object v3, v0, Lcom/rokid/security/sdk/ability/param/ProductIdentifyResponse;->brand:Ljava/lang/String;

    goto :goto_1

    :cond_1
    move-object/from16 v3, p2

    :goto_1
    and-int/lit8 v4, v1, 0x4

    if-eqz v4, :cond_2

    iget-object v4, v0, Lcom/rokid/security/sdk/ability/param/ProductIdentifyResponse;->categoryCode:Ljava/lang/String;

    goto :goto_2

    :cond_2
    move-object/from16 v4, p3

    :goto_2
    and-int/lit8 v5, v1, 0x8

    if-eqz v5, :cond_3

    iget v5, v0, Lcom/rokid/security/sdk/ability/param/ProductIdentifyResponse;->deleted:I

    goto :goto_3

    :cond_3
    move/from16 v5, p4

    :goto_3
    and-int/lit8 v6, v1, 0x10

    if-eqz v6, :cond_4

    iget-wide v6, v0, Lcom/rokid/security/sdk/ability/param/ProductIdentifyResponse;->gmtCreated:J

    goto :goto_4

    :cond_4
    move-wide/from16 v6, p5

    :goto_4
    and-int/lit8 v8, v1, 0x20

    if-eqz v8, :cond_5

    iget-wide v8, v0, Lcom/rokid/security/sdk/ability/param/ProductIdentifyResponse;->gmtModified:J

    goto :goto_5

    :cond_5
    move-wide/from16 v8, p7

    :goto_5
    and-int/lit8 v10, v1, 0x40

    if-eqz v10, :cond_6

    iget v10, v0, Lcom/rokid/security/sdk/ability/param/ProductIdentifyResponse;->id:I

    goto :goto_6

    :cond_6
    move/from16 v10, p9

    :goto_6
    and-int/lit16 v11, v1, 0x80

    if-eqz v11, :cond_7

    iget-object v11, v0, Lcom/rokid/security/sdk/ability/param/ProductIdentifyResponse;->itemCategory:Ljava/lang/String;

    goto :goto_7

    :cond_7
    move-object/from16 v11, p10

    :goto_7
    and-int/lit16 v12, v1, 0x100

    if-eqz v12, :cond_8

    iget-object v12, v0, Lcom/rokid/security/sdk/ability/param/ProductIdentifyResponse;->name:Ljava/lang/String;

    goto :goto_8

    :cond_8
    move-object/from16 v12, p11

    :goto_8
    and-int/lit16 v13, v1, 0x200

    if-eqz v13, :cond_9

    iget-wide v13, v0, Lcom/rokid/security/sdk/ability/param/ProductIdentifyResponse;->price:D

    goto :goto_9

    :cond_9
    move-wide/from16 v13, p12

    :goto_9
    and-int/lit16 v15, v1, 0x400

    if-eqz v15, :cond_a

    iget-object v15, v0, Lcom/rokid/security/sdk/ability/param/ProductIdentifyResponse;->specifications:Ljava/lang/String;

    goto :goto_a

    :cond_a
    move-object/from16 v15, p14

    :goto_a
    move-object/from16 p14, v15

    and-int/lit16 v15, v1, 0x800

    if-eqz v15, :cond_b

    iget-object v15, v0, Lcom/rokid/security/sdk/ability/param/ProductIdentifyResponse;->subItemCategory:Ljava/lang/String;

    goto :goto_b

    :cond_b
    move-object/from16 v15, p15

    :goto_b
    and-int/lit16 v1, v1, 0x1000

    if-eqz v1, :cond_c

    iget-object v1, v0, Lcom/rokid/security/sdk/ability/param/ProductIdentifyResponse;->unit:Ljava/lang/String;

    goto :goto_c

    :cond_c
    move-object/from16 v1, p16

    :goto_c
    move-object/from16 p1, v2

    move-object/from16 p2, v3

    move-object/from16 p3, v4

    move/from16 p4, v5

    move-wide/from16 p5, v6

    move-wide/from16 p7, v8

    move/from16 p9, v10

    move-object/from16 p10, v11

    move-object/from16 p11, v12

    move-wide/from16 p12, v13

    move-object/from16 p15, v15

    move-object/from16 p16, v1

    invoke-virtual/range {p0 .. p16}, Lcom/rokid/security/sdk/ability/param/ProductIdentifyResponse;->copy(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;IJJILjava/lang/String;Ljava/lang/String;DLjava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lcom/rokid/security/sdk/ability/param/ProductIdentifyResponse;

    move-result-object v0

    return-object v0
.end method


# virtual methods
.method public final component1()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/rokid/security/sdk/ability/param/ProductIdentifyResponse;->barcode:Ljava/lang/String;

    return-object v0
.end method

.method public final component10()D
    .locals 2

    iget-wide v0, p0, Lcom/rokid/security/sdk/ability/param/ProductIdentifyResponse;->price:D

    return-wide v0
.end method

.method public final component11()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/rokid/security/sdk/ability/param/ProductIdentifyResponse;->specifications:Ljava/lang/String;

    return-object v0
.end method

.method public final component12()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/rokid/security/sdk/ability/param/ProductIdentifyResponse;->subItemCategory:Ljava/lang/String;

    return-object v0
.end method

.method public final component13()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/rokid/security/sdk/ability/param/ProductIdentifyResponse;->unit:Ljava/lang/String;

    return-object v0
.end method

.method public final component2()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/rokid/security/sdk/ability/param/ProductIdentifyResponse;->brand:Ljava/lang/String;

    return-object v0
.end method

.method public final component3()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/rokid/security/sdk/ability/param/ProductIdentifyResponse;->categoryCode:Ljava/lang/String;

    return-object v0
.end method

.method public final component4()I
    .locals 1

    iget v0, p0, Lcom/rokid/security/sdk/ability/param/ProductIdentifyResponse;->deleted:I

    return v0
.end method

.method public final component5()J
    .locals 2

    iget-wide v0, p0, Lcom/rokid/security/sdk/ability/param/ProductIdentifyResponse;->gmtCreated:J

    return-wide v0
.end method

.method public final component6()J
    .locals 2

    iget-wide v0, p0, Lcom/rokid/security/sdk/ability/param/ProductIdentifyResponse;->gmtModified:J

    return-wide v0
.end method

.method public final component7()I
    .locals 1

    iget v0, p0, Lcom/rokid/security/sdk/ability/param/ProductIdentifyResponse;->id:I

    return v0
.end method

.method public final component8()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/rokid/security/sdk/ability/param/ProductIdentifyResponse;->itemCategory:Ljava/lang/String;

    return-object v0
.end method

.method public final component9()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/rokid/security/sdk/ability/param/ProductIdentifyResponse;->name:Ljava/lang/String;

    return-object v0
.end method

.method public final copy(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;IJJILjava/lang/String;Ljava/lang/String;DLjava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lcom/rokid/security/sdk/ability/param/ProductIdentifyResponse;
    .locals 19

    move-object/from16 v1, p1

    move-object/from16 v2, p2

    move-object/from16 v3, p3

    move/from16 v4, p4

    move-wide/from16 v5, p5

    move-wide/from16 v7, p7

    move/from16 v9, p9

    move-object/from16 v10, p10

    move-object/from16 v11, p11

    move-wide/from16 v12, p12

    move-object/from16 v14, p14

    move-object/from16 v15, p15

    move-object/from16 v16, p16

    const-string v0, "barcode"

    move-object/from16 v17, v1

    invoke-static {v1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "brand"

    move-object/from16 v1, p2

    invoke-static {v1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "categoryCode"

    move-object/from16 v1, p3

    invoke-static {v1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "itemCategory"

    move-object/from16 v1, p10

    invoke-static {v1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "name"

    move-object/from16 v1, p11

    invoke-static {v1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string/jumbo v0, "specifications"

    move-object/from16 v1, p14

    invoke-static {v1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string/jumbo v0, "subItemCategory"

    move-object/from16 v1, p15

    invoke-static {v1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string/jumbo v0, "unit"

    move-object/from16 v1, p16

    invoke-static {v1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    new-instance v18, Lcom/rokid/security/sdk/ability/param/ProductIdentifyResponse;

    move-object/from16 v0, v18

    move-object/from16 v1, v17

    invoke-direct/range {v0 .. v16}, Lcom/rokid/security/sdk/ability/param/ProductIdentifyResponse;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;IJJILjava/lang/String;Ljava/lang/String;DLjava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    return-object v18
.end method

.method public equals(Ljava/lang/Object;)Z
    .locals 7

    const/4 v0, 0x1

    if-ne p0, p1, :cond_0

    return v0

    :cond_0
    instance-of v1, p1, Lcom/rokid/security/sdk/ability/param/ProductIdentifyResponse;

    const/4 v2, 0x0

    if-nez v1, :cond_1

    return v2

    :cond_1
    move-object v1, p1

    check-cast v1, Lcom/rokid/security/sdk/ability/param/ProductIdentifyResponse;

    iget-object v3, p0, Lcom/rokid/security/sdk/ability/param/ProductIdentifyResponse;->barcode:Ljava/lang/String;

    iget-object v4, v1, Lcom/rokid/security/sdk/ability/param/ProductIdentifyResponse;->barcode:Ljava/lang/String;

    invoke-static {v3, v4}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_2

    return v2

    :cond_2
    iget-object v3, p0, Lcom/rokid/security/sdk/ability/param/ProductIdentifyResponse;->brand:Ljava/lang/String;

    iget-object v4, v1, Lcom/rokid/security/sdk/ability/param/ProductIdentifyResponse;->brand:Ljava/lang/String;

    invoke-static {v3, v4}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_3

    return v2

    :cond_3
    iget-object v3, p0, Lcom/rokid/security/sdk/ability/param/ProductIdentifyResponse;->categoryCode:Ljava/lang/String;

    iget-object v4, v1, Lcom/rokid/security/sdk/ability/param/ProductIdentifyResponse;->categoryCode:Ljava/lang/String;

    invoke-static {v3, v4}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_4

    return v2

    :cond_4
    iget v3, p0, Lcom/rokid/security/sdk/ability/param/ProductIdentifyResponse;->deleted:I

    iget v4, v1, Lcom/rokid/security/sdk/ability/param/ProductIdentifyResponse;->deleted:I

    if-eq v3, v4, :cond_5

    return v2

    :cond_5
    iget-wide v3, p0, Lcom/rokid/security/sdk/ability/param/ProductIdentifyResponse;->gmtCreated:J

    iget-wide v5, v1, Lcom/rokid/security/sdk/ability/param/ProductIdentifyResponse;->gmtCreated:J

    cmp-long v3, v3, v5

    if-eqz v3, :cond_6

    return v2

    :cond_6
    iget-wide v3, p0, Lcom/rokid/security/sdk/ability/param/ProductIdentifyResponse;->gmtModified:J

    iget-wide v5, v1, Lcom/rokid/security/sdk/ability/param/ProductIdentifyResponse;->gmtModified:J

    cmp-long v3, v3, v5

    if-eqz v3, :cond_7

    return v2

    :cond_7
    iget v3, p0, Lcom/rokid/security/sdk/ability/param/ProductIdentifyResponse;->id:I

    iget v4, v1, Lcom/rokid/security/sdk/ability/param/ProductIdentifyResponse;->id:I

    if-eq v3, v4, :cond_8

    return v2

    :cond_8
    iget-object v3, p0, Lcom/rokid/security/sdk/ability/param/ProductIdentifyResponse;->itemCategory:Ljava/lang/String;

    iget-object v4, v1, Lcom/rokid/security/sdk/ability/param/ProductIdentifyResponse;->itemCategory:Ljava/lang/String;

    invoke-static {v3, v4}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_9

    return v2

    :cond_9
    iget-object v3, p0, Lcom/rokid/security/sdk/ability/param/ProductIdentifyResponse;->name:Ljava/lang/String;

    iget-object v4, v1, Lcom/rokid/security/sdk/ability/param/ProductIdentifyResponse;->name:Ljava/lang/String;

    invoke-static {v3, v4}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_a

    return v2

    :cond_a
    iget-wide v3, p0, Lcom/rokid/security/sdk/ability/param/ProductIdentifyResponse;->price:D

    iget-wide v5, v1, Lcom/rokid/security/sdk/ability/param/ProductIdentifyResponse;->price:D

    invoke-static {v3, v4, v5, v6}, Ljava/lang/Double;->compare(DD)I

    move-result v3

    if-eqz v3, :cond_b

    return v2

    :cond_b
    iget-object v3, p0, Lcom/rokid/security/sdk/ability/param/ProductIdentifyResponse;->specifications:Ljava/lang/String;

    iget-object v4, v1, Lcom/rokid/security/sdk/ability/param/ProductIdentifyResponse;->specifications:Ljava/lang/String;

    invoke-static {v3, v4}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_c

    return v2

    :cond_c
    iget-object v3, p0, Lcom/rokid/security/sdk/ability/param/ProductIdentifyResponse;->subItemCategory:Ljava/lang/String;

    iget-object v4, v1, Lcom/rokid/security/sdk/ability/param/ProductIdentifyResponse;->subItemCategory:Ljava/lang/String;

    invoke-static {v3, v4}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_d

    return v2

    :cond_d
    iget-object v3, p0, Lcom/rokid/security/sdk/ability/param/ProductIdentifyResponse;->unit:Ljava/lang/String;

    iget-object v1, v1, Lcom/rokid/security/sdk/ability/param/ProductIdentifyResponse;->unit:Ljava/lang/String;

    invoke-static {v3, v1}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_e

    return v2

    :cond_e
    return v0
.end method

.method public final getBarcode()Ljava/lang/String;
    .locals 1

    .line 96
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/param/ProductIdentifyResponse;->barcode:Ljava/lang/String;

    return-object v0
.end method

.method public final getBrand()Ljava/lang/String;
    .locals 1

    .line 97
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/param/ProductIdentifyResponse;->brand:Ljava/lang/String;

    return-object v0
.end method

.method public final getCategoryCode()Ljava/lang/String;
    .locals 1

    .line 98
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/param/ProductIdentifyResponse;->categoryCode:Ljava/lang/String;

    return-object v0
.end method

.method public final getDeleted()I
    .locals 1

    .line 99
    iget v0, p0, Lcom/rokid/security/sdk/ability/param/ProductIdentifyResponse;->deleted:I

    return v0
.end method

.method public final getGmtCreated()J
    .locals 2

    .line 100
    iget-wide v0, p0, Lcom/rokid/security/sdk/ability/param/ProductIdentifyResponse;->gmtCreated:J

    return-wide v0
.end method

.method public final getGmtModified()J
    .locals 2

    .line 101
    iget-wide v0, p0, Lcom/rokid/security/sdk/ability/param/ProductIdentifyResponse;->gmtModified:J

    return-wide v0
.end method

.method public final getId()I
    .locals 1

    .line 102
    iget v0, p0, Lcom/rokid/security/sdk/ability/param/ProductIdentifyResponse;->id:I

    return v0
.end method

.method public final getItemCategory()Ljava/lang/String;
    .locals 1

    .line 103
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/param/ProductIdentifyResponse;->itemCategory:Ljava/lang/String;

    return-object v0
.end method

.method public final getName()Ljava/lang/String;
    .locals 1

    .line 104
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/param/ProductIdentifyResponse;->name:Ljava/lang/String;

    return-object v0
.end method

.method public final getPrice()D
    .locals 2

    .line 105
    iget-wide v0, p0, Lcom/rokid/security/sdk/ability/param/ProductIdentifyResponse;->price:D

    return-wide v0
.end method

.method public final getSpecifications()Ljava/lang/String;
    .locals 1

    .line 106
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/param/ProductIdentifyResponse;->specifications:Ljava/lang/String;

    return-object v0
.end method

.method public final getSubItemCategory()Ljava/lang/String;
    .locals 1

    .line 107
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/param/ProductIdentifyResponse;->subItemCategory:Ljava/lang/String;

    return-object v0
.end method

.method public final getUnit()Ljava/lang/String;
    .locals 1

    .line 108
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/param/ProductIdentifyResponse;->unit:Ljava/lang/String;

    return-object v0
.end method

.method public hashCode()I
    .locals 4

    iget-object v0, p0, Lcom/rokid/security/sdk/ability/param/ProductIdentifyResponse;->barcode:Ljava/lang/String;

    invoke-virtual {v0}, Ljava/lang/String;->hashCode()I

    move-result v0

    mul-int/lit8 v1, v0, 0x1f

    iget-object v2, p0, Lcom/rokid/security/sdk/ability/param/ProductIdentifyResponse;->brand:Ljava/lang/String;

    invoke-virtual {v2}, Ljava/lang/String;->hashCode()I

    move-result v2

    add-int/2addr v1, v2

    mul-int/lit8 v0, v1, 0x1f

    iget-object v2, p0, Lcom/rokid/security/sdk/ability/param/ProductIdentifyResponse;->categoryCode:Ljava/lang/String;

    invoke-virtual {v2}, Ljava/lang/String;->hashCode()I

    move-result v2

    add-int/2addr v0, v2

    mul-int/lit8 v1, v0, 0x1f

    iget v2, p0, Lcom/rokid/security/sdk/ability/param/ProductIdentifyResponse;->deleted:I

    invoke-static {v2}, Ljava/lang/Integer;->hashCode(I)I

    move-result v2

    add-int/2addr v1, v2

    mul-int/lit8 v0, v1, 0x1f

    iget-wide v2, p0, Lcom/rokid/security/sdk/ability/param/ProductIdentifyResponse;->gmtCreated:J

    invoke-static {v2, v3}, Ljava/lang/Long;->hashCode(J)I

    move-result v2

    add-int/2addr v0, v2

    mul-int/lit8 v1, v0, 0x1f

    iget-wide v2, p0, Lcom/rokid/security/sdk/ability/param/ProductIdentifyResponse;->gmtModified:J

    invoke-static {v2, v3}, Ljava/lang/Long;->hashCode(J)I

    move-result v2

    add-int/2addr v1, v2

    mul-int/lit8 v0, v1, 0x1f

    iget v2, p0, Lcom/rokid/security/sdk/ability/param/ProductIdentifyResponse;->id:I

    invoke-static {v2}, Ljava/lang/Integer;->hashCode(I)I

    move-result v2

    add-int/2addr v0, v2

    mul-int/lit8 v1, v0, 0x1f

    iget-object v2, p0, Lcom/rokid/security/sdk/ability/param/ProductIdentifyResponse;->itemCategory:Ljava/lang/String;

    invoke-virtual {v2}, Ljava/lang/String;->hashCode()I

    move-result v2

    add-int/2addr v1, v2

    mul-int/lit8 v0, v1, 0x1f

    iget-object v2, p0, Lcom/rokid/security/sdk/ability/param/ProductIdentifyResponse;->name:Ljava/lang/String;

    invoke-virtual {v2}, Ljava/lang/String;->hashCode()I

    move-result v2

    add-int/2addr v0, v2

    mul-int/lit8 v1, v0, 0x1f

    iget-wide v2, p0, Lcom/rokid/security/sdk/ability/param/ProductIdentifyResponse;->price:D

    invoke-static {v2, v3}, Ljava/lang/Double;->hashCode(D)I

    move-result v2

    add-int/2addr v1, v2

    mul-int/lit8 v0, v1, 0x1f

    iget-object v2, p0, Lcom/rokid/security/sdk/ability/param/ProductIdentifyResponse;->specifications:Ljava/lang/String;

    invoke-virtual {v2}, Ljava/lang/String;->hashCode()I

    move-result v2

    add-int/2addr v0, v2

    mul-int/lit8 v1, v0, 0x1f

    iget-object v2, p0, Lcom/rokid/security/sdk/ability/param/ProductIdentifyResponse;->subItemCategory:Ljava/lang/String;

    invoke-virtual {v2}, Ljava/lang/String;->hashCode()I

    move-result v2

    add-int/2addr v1, v2

    mul-int/lit8 v0, v1, 0x1f

    iget-object v2, p0, Lcom/rokid/security/sdk/ability/param/ProductIdentifyResponse;->unit:Ljava/lang/String;

    invoke-virtual {v2}, Ljava/lang/String;->hashCode()I

    move-result v2

    add-int/2addr v0, v2

    return v0
.end method

.method public toString()Ljava/lang/String;
    .locals 4

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "ProductIdentifyResponse(barcode="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/rokid/security/sdk/ability/param/ProductIdentifyResponse;->barcode:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ", brand="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/rokid/security/sdk/ability/param/ProductIdentifyResponse;->brand:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ", categoryCode="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/rokid/security/sdk/ability/param/ProductIdentifyResponse;->categoryCode:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ", deleted="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget v2, p0, Lcom/rokid/security/sdk/ability/param/ProductIdentifyResponse;->deleted:I

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ", gmtCreated="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-wide v2, p0, Lcom/rokid/security/sdk/ability/param/ProductIdentifyResponse;->gmtCreated:J

    invoke-virtual {v1, v2, v3}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ", gmtModified="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-wide v2, p0, Lcom/rokid/security/sdk/ability/param/ProductIdentifyResponse;->gmtModified:J

    invoke-virtual {v1, v2, v3}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ", id="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget v2, p0, Lcom/rokid/security/sdk/ability/param/ProductIdentifyResponse;->id:I

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ", itemCategory="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/rokid/security/sdk/ability/param/ProductIdentifyResponse;->itemCategory:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ", name="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/rokid/security/sdk/ability/param/ProductIdentifyResponse;->name:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ", price="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-wide v2, p0, Lcom/rokid/security/sdk/ability/param/ProductIdentifyResponse;->price:D

    invoke-virtual {v1, v2, v3}, Ljava/lang/StringBuilder;->append(D)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ", specifications="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/rokid/security/sdk/ability/param/ProductIdentifyResponse;->specifications:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ", subItemCategory="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v1, p0, Lcom/rokid/security/sdk/ability/param/ProductIdentifyResponse;->subItemCategory:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ", unit="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/rokid/security/sdk/ability/param/ProductIdentifyResponse;->unit:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const/16 v2, 0x29

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
