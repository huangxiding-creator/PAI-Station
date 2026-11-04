.class public final Lcom/rokid/security/sdk/ability/param/RecognizedFaceSubmitParam;
.super Ljava/lang/Object;
.source "RecognizedFaceSubmitParam.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000*\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0000\n\u0002\u0010\u000e\n\u0002\u0008\u0007\n\u0002\u0018\u0002\n\u0002\u0008\u0015\n\u0002\u0010\u000b\n\u0002\u0008\u0002\n\u0002\u0010\u0008\n\u0002\u0008\u0002\u0008\u0086\u0008\u0018\u00002\u00020\u0001BM\u0012\u0006\u0010\u0002\u001a\u00020\u0003\u0012\u0006\u0010\u0004\u001a\u00020\u0003\u0012\u0006\u0010\u0005\u001a\u00020\u0003\u0012\u0008\u0010\u0006\u001a\u0004\u0018\u00010\u0003\u0012\u0008\u0010\u0007\u001a\u0004\u0018\u00010\u0003\u0012\u0006\u0010\u0008\u001a\u00020\u0003\u0012\u0008\u0010\t\u001a\u0004\u0018\u00010\u0003\u0012\u0008\u0010\n\u001a\u0004\u0018\u00010\u000b\u00a2\u0006\u0002\u0010\u000cJ\t\u0010\u0017\u001a\u00020\u0003H\u00c6\u0003J\t\u0010\u0018\u001a\u00020\u0003H\u00c6\u0003J\t\u0010\u0019\u001a\u00020\u0003H\u00c6\u0003J\u000b\u0010\u001a\u001a\u0004\u0018\u00010\u0003H\u00c6\u0003J\u000b\u0010\u001b\u001a\u0004\u0018\u00010\u0003H\u00c6\u0003J\t\u0010\u001c\u001a\u00020\u0003H\u00c6\u0003J\u000b\u0010\u001d\u001a\u0004\u0018\u00010\u0003H\u00c6\u0003J\u000b\u0010\u001e\u001a\u0004\u0018\u00010\u000bH\u00c6\u0003Ja\u0010\u001f\u001a\u00020\u00002\u0008\u0008\u0002\u0010\u0002\u001a\u00020\u00032\u0008\u0008\u0002\u0010\u0004\u001a\u00020\u00032\u0008\u0008\u0002\u0010\u0005\u001a\u00020\u00032\n\u0008\u0002\u0010\u0006\u001a\u0004\u0018\u00010\u00032\n\u0008\u0002\u0010\u0007\u001a\u0004\u0018\u00010\u00032\u0008\u0008\u0002\u0010\u0008\u001a\u00020\u00032\n\u0008\u0002\u0010\t\u001a\u0004\u0018\u00010\u00032\n\u0008\u0002\u0010\n\u001a\u0004\u0018\u00010\u000bH\u00c6\u0001J\u0013\u0010 \u001a\u00020!2\u0008\u0010\"\u001a\u0004\u0018\u00010\u0001H\u00d6\u0003J\t\u0010#\u001a\u00020$H\u00d6\u0001J\t\u0010%\u001a\u00020\u0003H\u00d6\u0001R\u0013\u0010\t\u001a\u0004\u0018\u00010\u0003\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\r\u0010\u000eR\u0013\u0010\n\u001a\u0004\u0018\u00010\u000b\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\u000f\u0010\u0010R\u0011\u0010\u0002\u001a\u00020\u0003\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\u0011\u0010\u000eR\u0011\u0010\u0005\u001a\u00020\u0003\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\u0012\u0010\u000eR\u0011\u0010\u0008\u001a\u00020\u0003\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\u0013\u0010\u000eR\u0013\u0010\u0006\u001a\u0004\u0018\u00010\u0003\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\u0014\u0010\u000eR\u0013\u0010\u0007\u001a\u0004\u0018\u00010\u0003\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\u0015\u0010\u000eR\u0011\u0010\u0004\u001a\u00020\u0003\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\u0016\u0010\u000e\u00a8\u0006&"
    }
    d2 = {
        "Lcom/rokid/security/sdk/ability/param/RecognizedFaceSubmitParam;",
        "",
        "imageBase64",
        "",
        "similarity",
        "libId",
        "recognitionPersonId",
        "recognitionPersonName",
        "libModel",
        "checkType",
        "device_meta",
        "Lcom/rokid/security/sdk/ability/param/DeviceInfo;",
        "(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/rokid/security/sdk/ability/param/DeviceInfo;)V",
        "getCheckType",
        "()Ljava/lang/String;",
        "getDevice_meta",
        "()Lcom/rokid/security/sdk/ability/param/DeviceInfo;",
        "getImageBase64",
        "getLibId",
        "getLibModel",
        "getRecognitionPersonId",
        "getRecognitionPersonName",
        "getSimilarity",
        "component1",
        "component2",
        "component3",
        "component4",
        "component5",
        "component6",
        "component7",
        "component8",
        "copy",
        "equals",
        "",
        "other",
        "hashCode",
        "",
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
.field private final checkType:Ljava/lang/String;

.field private final device_meta:Lcom/rokid/security/sdk/ability/param/DeviceInfo;

.field private final imageBase64:Ljava/lang/String;

.field private final libId:Ljava/lang/String;

.field private final libModel:Ljava/lang/String;

.field private final recognitionPersonId:Ljava/lang/String;

.field private final recognitionPersonName:Ljava/lang/String;

.field private final similarity:Ljava/lang/String;


# direct methods
.method public constructor <init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/rokid/security/sdk/ability/param/DeviceInfo;)V
    .locals 1
    .param p1, "imageBase64"    # Ljava/lang/String;
    .param p2, "similarity"    # Ljava/lang/String;
    .param p3, "libId"    # Ljava/lang/String;
    .param p4, "recognitionPersonId"    # Ljava/lang/String;
    .param p5, "recognitionPersonName"    # Ljava/lang/String;
    .param p6, "libModel"    # Ljava/lang/String;
    .param p7, "checkType"    # Ljava/lang/String;
    .param p8, "device_meta"    # Lcom/rokid/security/sdk/ability/param/DeviceInfo;

    const-string v0, "imageBase64"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string/jumbo v0, "similarity"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "libId"

    invoke-static {p3, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "libModel"

    invoke-static {p6, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 6
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 7
    iput-object p1, p0, Lcom/rokid/security/sdk/ability/param/RecognizedFaceSubmitParam;->imageBase64:Ljava/lang/String;

    .line 8
    iput-object p2, p0, Lcom/rokid/security/sdk/ability/param/RecognizedFaceSubmitParam;->similarity:Ljava/lang/String;

    .line 9
    iput-object p3, p0, Lcom/rokid/security/sdk/ability/param/RecognizedFaceSubmitParam;->libId:Ljava/lang/String;

    .line 10
    iput-object p4, p0, Lcom/rokid/security/sdk/ability/param/RecognizedFaceSubmitParam;->recognitionPersonId:Ljava/lang/String;

    .line 11
    iput-object p5, p0, Lcom/rokid/security/sdk/ability/param/RecognizedFaceSubmitParam;->recognitionPersonName:Ljava/lang/String;

    .line 12
    iput-object p6, p0, Lcom/rokid/security/sdk/ability/param/RecognizedFaceSubmitParam;->libModel:Ljava/lang/String;

    .line 13
    iput-object p7, p0, Lcom/rokid/security/sdk/ability/param/RecognizedFaceSubmitParam;->checkType:Ljava/lang/String;

    .line 14
    iput-object p8, p0, Lcom/rokid/security/sdk/ability/param/RecognizedFaceSubmitParam;->device_meta:Lcom/rokid/security/sdk/ability/param/DeviceInfo;

    .line 6
    return-void
.end method

.method public static synthetic copy$default(Lcom/rokid/security/sdk/ability/param/RecognizedFaceSubmitParam;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/rokid/security/sdk/ability/param/DeviceInfo;ILjava/lang/Object;)Lcom/rokid/security/sdk/ability/param/RecognizedFaceSubmitParam;
    .locals 9

    move-object v0, p0

    move/from16 v1, p9

    and-int/lit8 v2, v1, 0x1

    if-eqz v2, :cond_0

    iget-object v2, v0, Lcom/rokid/security/sdk/ability/param/RecognizedFaceSubmitParam;->imageBase64:Ljava/lang/String;

    goto :goto_0

    :cond_0
    move-object v2, p1

    :goto_0
    and-int/lit8 v3, v1, 0x2

    if-eqz v3, :cond_1

    iget-object v3, v0, Lcom/rokid/security/sdk/ability/param/RecognizedFaceSubmitParam;->similarity:Ljava/lang/String;

    goto :goto_1

    :cond_1
    move-object v3, p2

    :goto_1
    and-int/lit8 v4, v1, 0x4

    if-eqz v4, :cond_2

    iget-object v4, v0, Lcom/rokid/security/sdk/ability/param/RecognizedFaceSubmitParam;->libId:Ljava/lang/String;

    goto :goto_2

    :cond_2
    move-object v4, p3

    :goto_2
    and-int/lit8 v5, v1, 0x8

    if-eqz v5, :cond_3

    iget-object v5, v0, Lcom/rokid/security/sdk/ability/param/RecognizedFaceSubmitParam;->recognitionPersonId:Ljava/lang/String;

    goto :goto_3

    :cond_3
    move-object v5, p4

    :goto_3
    and-int/lit8 v6, v1, 0x10

    if-eqz v6, :cond_4

    iget-object v6, v0, Lcom/rokid/security/sdk/ability/param/RecognizedFaceSubmitParam;->recognitionPersonName:Ljava/lang/String;

    goto :goto_4

    :cond_4
    move-object v6, p5

    :goto_4
    and-int/lit8 v7, v1, 0x20

    if-eqz v7, :cond_5

    iget-object v7, v0, Lcom/rokid/security/sdk/ability/param/RecognizedFaceSubmitParam;->libModel:Ljava/lang/String;

    goto :goto_5

    :cond_5
    move-object v7, p6

    :goto_5
    and-int/lit8 v8, v1, 0x40

    if-eqz v8, :cond_6

    iget-object v8, v0, Lcom/rokid/security/sdk/ability/param/RecognizedFaceSubmitParam;->checkType:Ljava/lang/String;

    goto :goto_6

    :cond_6
    move-object/from16 v8, p7

    :goto_6
    and-int/lit16 v1, v1, 0x80

    if-eqz v1, :cond_7

    iget-object v1, v0, Lcom/rokid/security/sdk/ability/param/RecognizedFaceSubmitParam;->device_meta:Lcom/rokid/security/sdk/ability/param/DeviceInfo;

    goto :goto_7

    :cond_7
    move-object/from16 v1, p8

    :goto_7
    move-object p1, v2

    move-object p2, v3

    move-object p3, v4

    move-object p4, v5

    move-object p5, v6

    move-object p6, v7

    move-object/from16 p7, v8

    move-object/from16 p8, v1

    invoke-virtual/range {p0 .. p8}, Lcom/rokid/security/sdk/ability/param/RecognizedFaceSubmitParam;->copy(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/rokid/security/sdk/ability/param/DeviceInfo;)Lcom/rokid/security/sdk/ability/param/RecognizedFaceSubmitParam;

    move-result-object v0

    return-object v0
.end method


# virtual methods
.method public final component1()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/rokid/security/sdk/ability/param/RecognizedFaceSubmitParam;->imageBase64:Ljava/lang/String;

    return-object v0
.end method

.method public final component2()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/rokid/security/sdk/ability/param/RecognizedFaceSubmitParam;->similarity:Ljava/lang/String;

    return-object v0
.end method

.method public final component3()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/rokid/security/sdk/ability/param/RecognizedFaceSubmitParam;->libId:Ljava/lang/String;

    return-object v0
.end method

.method public final component4()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/rokid/security/sdk/ability/param/RecognizedFaceSubmitParam;->recognitionPersonId:Ljava/lang/String;

    return-object v0
.end method

.method public final component5()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/rokid/security/sdk/ability/param/RecognizedFaceSubmitParam;->recognitionPersonName:Ljava/lang/String;

    return-object v0
.end method

.method public final component6()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/rokid/security/sdk/ability/param/RecognizedFaceSubmitParam;->libModel:Ljava/lang/String;

    return-object v0
.end method

.method public final component7()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/rokid/security/sdk/ability/param/RecognizedFaceSubmitParam;->checkType:Ljava/lang/String;

    return-object v0
.end method

.method public final component8()Lcom/rokid/security/sdk/ability/param/DeviceInfo;
    .locals 1

    iget-object v0, p0, Lcom/rokid/security/sdk/ability/param/RecognizedFaceSubmitParam;->device_meta:Lcom/rokid/security/sdk/ability/param/DeviceInfo;

    return-object v0
.end method

.method public final copy(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/rokid/security/sdk/ability/param/DeviceInfo;)Lcom/rokid/security/sdk/ability/param/RecognizedFaceSubmitParam;
    .locals 14

    const-string v0, "imageBase64"

    move-object v10, p1

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string/jumbo v0, "similarity"

    move-object/from16 v11, p2

    invoke-static {v11, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "libId"

    move-object/from16 v12, p3

    invoke-static {v12, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "libModel"

    move-object/from16 v13, p6

    invoke-static {v13, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    new-instance v0, Lcom/rokid/security/sdk/ability/param/RecognizedFaceSubmitParam;

    move-object v1, v0

    move-object v2, p1

    move-object/from16 v3, p2

    move-object/from16 v4, p3

    move-object/from16 v5, p4

    move-object/from16 v6, p5

    move-object/from16 v7, p6

    move-object/from16 v8, p7

    move-object/from16 v9, p8

    invoke-direct/range {v1 .. v9}, Lcom/rokid/security/sdk/ability/param/RecognizedFaceSubmitParam;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/rokid/security/sdk/ability/param/DeviceInfo;)V

    return-object v0
.end method

.method public equals(Ljava/lang/Object;)Z
    .locals 5

    const/4 v0, 0x1

    if-ne p0, p1, :cond_0

    return v0

    :cond_0
    instance-of v1, p1, Lcom/rokid/security/sdk/ability/param/RecognizedFaceSubmitParam;

    const/4 v2, 0x0

    if-nez v1, :cond_1

    return v2

    :cond_1
    move-object v1, p1

    check-cast v1, Lcom/rokid/security/sdk/ability/param/RecognizedFaceSubmitParam;

    iget-object v3, p0, Lcom/rokid/security/sdk/ability/param/RecognizedFaceSubmitParam;->imageBase64:Ljava/lang/String;

    iget-object v4, v1, Lcom/rokid/security/sdk/ability/param/RecognizedFaceSubmitParam;->imageBase64:Ljava/lang/String;

    invoke-static {v3, v4}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_2

    return v2

    :cond_2
    iget-object v3, p0, Lcom/rokid/security/sdk/ability/param/RecognizedFaceSubmitParam;->similarity:Ljava/lang/String;

    iget-object v4, v1, Lcom/rokid/security/sdk/ability/param/RecognizedFaceSubmitParam;->similarity:Ljava/lang/String;

    invoke-static {v3, v4}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_3

    return v2

    :cond_3
    iget-object v3, p0, Lcom/rokid/security/sdk/ability/param/RecognizedFaceSubmitParam;->libId:Ljava/lang/String;

    iget-object v4, v1, Lcom/rokid/security/sdk/ability/param/RecognizedFaceSubmitParam;->libId:Ljava/lang/String;

    invoke-static {v3, v4}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_4

    return v2

    :cond_4
    iget-object v3, p0, Lcom/rokid/security/sdk/ability/param/RecognizedFaceSubmitParam;->recognitionPersonId:Ljava/lang/String;

    iget-object v4, v1, Lcom/rokid/security/sdk/ability/param/RecognizedFaceSubmitParam;->recognitionPersonId:Ljava/lang/String;

    invoke-static {v3, v4}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_5

    return v2

    :cond_5
    iget-object v3, p0, Lcom/rokid/security/sdk/ability/param/RecognizedFaceSubmitParam;->recognitionPersonName:Ljava/lang/String;

    iget-object v4, v1, Lcom/rokid/security/sdk/ability/param/RecognizedFaceSubmitParam;->recognitionPersonName:Ljava/lang/String;

    invoke-static {v3, v4}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_6

    return v2

    :cond_6
    iget-object v3, p0, Lcom/rokid/security/sdk/ability/param/RecognizedFaceSubmitParam;->libModel:Ljava/lang/String;

    iget-object v4, v1, Lcom/rokid/security/sdk/ability/param/RecognizedFaceSubmitParam;->libModel:Ljava/lang/String;

    invoke-static {v3, v4}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_7

    return v2

    :cond_7
    iget-object v3, p0, Lcom/rokid/security/sdk/ability/param/RecognizedFaceSubmitParam;->checkType:Ljava/lang/String;

    iget-object v4, v1, Lcom/rokid/security/sdk/ability/param/RecognizedFaceSubmitParam;->checkType:Ljava/lang/String;

    invoke-static {v3, v4}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_8

    return v2

    :cond_8
    iget-object v3, p0, Lcom/rokid/security/sdk/ability/param/RecognizedFaceSubmitParam;->device_meta:Lcom/rokid/security/sdk/ability/param/DeviceInfo;

    iget-object v1, v1, Lcom/rokid/security/sdk/ability/param/RecognizedFaceSubmitParam;->device_meta:Lcom/rokid/security/sdk/ability/param/DeviceInfo;

    invoke-static {v3, v1}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_9

    return v2

    :cond_9
    return v0
.end method

.method public final getCheckType()Ljava/lang/String;
    .locals 1

    .line 13
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/param/RecognizedFaceSubmitParam;->checkType:Ljava/lang/String;

    return-object v0
.end method

.method public final getDevice_meta()Lcom/rokid/security/sdk/ability/param/DeviceInfo;
    .locals 1

    .line 14
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/param/RecognizedFaceSubmitParam;->device_meta:Lcom/rokid/security/sdk/ability/param/DeviceInfo;

    return-object v0
.end method

.method public final getImageBase64()Ljava/lang/String;
    .locals 1

    .line 7
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/param/RecognizedFaceSubmitParam;->imageBase64:Ljava/lang/String;

    return-object v0
.end method

.method public final getLibId()Ljava/lang/String;
    .locals 1

    .line 9
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/param/RecognizedFaceSubmitParam;->libId:Ljava/lang/String;

    return-object v0
.end method

.method public final getLibModel()Ljava/lang/String;
    .locals 1

    .line 12
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/param/RecognizedFaceSubmitParam;->libModel:Ljava/lang/String;

    return-object v0
.end method

.method public final getRecognitionPersonId()Ljava/lang/String;
    .locals 1

    .line 10
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/param/RecognizedFaceSubmitParam;->recognitionPersonId:Ljava/lang/String;

    return-object v0
.end method

.method public final getRecognitionPersonName()Ljava/lang/String;
    .locals 1

    .line 11
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/param/RecognizedFaceSubmitParam;->recognitionPersonName:Ljava/lang/String;

    return-object v0
.end method

.method public final getSimilarity()Ljava/lang/String;
    .locals 1

    .line 8
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/param/RecognizedFaceSubmitParam;->similarity:Ljava/lang/String;

    return-object v0
.end method

.method public hashCode()I
    .locals 4

    iget-object v0, p0, Lcom/rokid/security/sdk/ability/param/RecognizedFaceSubmitParam;->imageBase64:Ljava/lang/String;

    invoke-virtual {v0}, Ljava/lang/String;->hashCode()I

    move-result v0

    mul-int/lit8 v1, v0, 0x1f

    iget-object v2, p0, Lcom/rokid/security/sdk/ability/param/RecognizedFaceSubmitParam;->similarity:Ljava/lang/String;

    invoke-virtual {v2}, Ljava/lang/String;->hashCode()I

    move-result v2

    add-int/2addr v1, v2

    mul-int/lit8 v0, v1, 0x1f

    iget-object v2, p0, Lcom/rokid/security/sdk/ability/param/RecognizedFaceSubmitParam;->libId:Ljava/lang/String;

    invoke-virtual {v2}, Ljava/lang/String;->hashCode()I

    move-result v2

    add-int/2addr v0, v2

    mul-int/lit8 v1, v0, 0x1f

    iget-object v2, p0, Lcom/rokid/security/sdk/ability/param/RecognizedFaceSubmitParam;->recognitionPersonId:Ljava/lang/String;

    const/4 v3, 0x0

    if-nez v2, :cond_0

    move v2, v3

    goto :goto_0

    :cond_0
    iget-object v2, p0, Lcom/rokid/security/sdk/ability/param/RecognizedFaceSubmitParam;->recognitionPersonId:Ljava/lang/String;

    invoke-virtual {v2}, Ljava/lang/String;->hashCode()I

    move-result v2

    :goto_0
    add-int/2addr v1, v2

    mul-int/lit8 v0, v1, 0x1f

    iget-object v2, p0, Lcom/rokid/security/sdk/ability/param/RecognizedFaceSubmitParam;->recognitionPersonName:Ljava/lang/String;

    if-nez v2, :cond_1

    move v2, v3

    goto :goto_1

    :cond_1
    iget-object v2, p0, Lcom/rokid/security/sdk/ability/param/RecognizedFaceSubmitParam;->recognitionPersonName:Ljava/lang/String;

    invoke-virtual {v2}, Ljava/lang/String;->hashCode()I

    move-result v2

    :goto_1
    add-int/2addr v0, v2

    mul-int/lit8 v1, v0, 0x1f

    iget-object v2, p0, Lcom/rokid/security/sdk/ability/param/RecognizedFaceSubmitParam;->libModel:Ljava/lang/String;

    invoke-virtual {v2}, Ljava/lang/String;->hashCode()I

    move-result v2

    add-int/2addr v1, v2

    mul-int/lit8 v0, v1, 0x1f

    iget-object v2, p0, Lcom/rokid/security/sdk/ability/param/RecognizedFaceSubmitParam;->checkType:Ljava/lang/String;

    if-nez v2, :cond_2

    move v2, v3

    goto :goto_2

    :cond_2
    iget-object v2, p0, Lcom/rokid/security/sdk/ability/param/RecognizedFaceSubmitParam;->checkType:Ljava/lang/String;

    invoke-virtual {v2}, Ljava/lang/String;->hashCode()I

    move-result v2

    :goto_2
    add-int/2addr v0, v2

    mul-int/lit8 v1, v0, 0x1f

    iget-object v2, p0, Lcom/rokid/security/sdk/ability/param/RecognizedFaceSubmitParam;->device_meta:Lcom/rokid/security/sdk/ability/param/DeviceInfo;

    if-nez v2, :cond_3

    goto :goto_3

    :cond_3
    iget-object v2, p0, Lcom/rokid/security/sdk/ability/param/RecognizedFaceSubmitParam;->device_meta:Lcom/rokid/security/sdk/ability/param/DeviceInfo;

    invoke-virtual {v2}, Lcom/rokid/security/sdk/ability/param/DeviceInfo;->hashCode()I

    move-result v3

    :goto_3
    add-int/2addr v1, v3

    return v1
.end method

.method public toString()Ljava/lang/String;
    .locals 2

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "RecognizedFaceSubmitParam(imageBase64="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/rokid/security/sdk/ability/param/RecognizedFaceSubmitParam;->imageBase64:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", similarity="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/rokid/security/sdk/ability/param/RecognizedFaceSubmitParam;->similarity:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", libId="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/rokid/security/sdk/ability/param/RecognizedFaceSubmitParam;->libId:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", recognitionPersonId="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/rokid/security/sdk/ability/param/RecognizedFaceSubmitParam;->recognitionPersonId:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", recognitionPersonName="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/rokid/security/sdk/ability/param/RecognizedFaceSubmitParam;->recognitionPersonName:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", libModel="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/rokid/security/sdk/ability/param/RecognizedFaceSubmitParam;->libModel:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", checkType="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/rokid/security/sdk/ability/param/RecognizedFaceSubmitParam;->checkType:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", device_meta="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/rokid/security/sdk/ability/param/RecognizedFaceSubmitParam;->device_meta:Lcom/rokid/security/sdk/ability/param/DeviceInfo;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    const/16 v1, 0x29

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
