.class public final Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;
.super Ljava/lang/Object;
.source "ResponseParam.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\"\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0000\n\u0002\u0010\u000e\n\u0002\u0008\u000b\n\u0002\u0010\u0008\n\u0002\u0008/\n\u0002\u0010\u000b\n\u0002\u0008\u0004\u0008\u0086\u0008\u0018\u00002\u00020\u0001B\u0095\u0001\u0012\u0006\u0010\u0002\u001a\u00020\u0003\u0012\u0006\u0010\u0004\u001a\u00020\u0003\u0012\u0006\u0010\u0005\u001a\u00020\u0003\u0012\u0006\u0010\u0006\u001a\u00020\u0003\u0012\u0006\u0010\u0007\u001a\u00020\u0003\u0012\u0006\u0010\u0008\u001a\u00020\u0003\u0012\u0006\u0010\t\u001a\u00020\u0003\u0012\u0006\u0010\n\u001a\u00020\u0003\u0012\u0006\u0010\u000b\u001a\u00020\u0003\u0012\u0006\u0010\u000c\u001a\u00020\u0003\u0012\u0006\u0010\r\u001a\u00020\u0003\u0012\u0006\u0010\u000e\u001a\u00020\u000f\u0012\u0006\u0010\u0010\u001a\u00020\u000f\u0012\u0006\u0010\u0011\u001a\u00020\u0003\u0012\u0006\u0010\u0012\u001a\u00020\u000f\u0012\u0006\u0010\u0013\u001a\u00020\u0003\u0012\u0006\u0010\u0014\u001a\u00020\u0003\u0012\u0006\u0010\u0015\u001a\u00020\u0003\u00a2\u0006\u0002\u0010\u0016J\t\u0010+\u001a\u00020\u0003H\u00c6\u0003J\t\u0010,\u001a\u00020\u0003H\u00c6\u0003J\t\u0010-\u001a\u00020\u0003H\u00c6\u0003J\t\u0010.\u001a\u00020\u000fH\u00c6\u0003J\t\u0010/\u001a\u00020\u000fH\u00c6\u0003J\t\u00100\u001a\u00020\u0003H\u00c6\u0003J\t\u00101\u001a\u00020\u000fH\u00c6\u0003J\t\u00102\u001a\u00020\u0003H\u00c6\u0003J\t\u00103\u001a\u00020\u0003H\u00c6\u0003J\t\u00104\u001a\u00020\u0003H\u00c6\u0003J\t\u00105\u001a\u00020\u0003H\u00c6\u0003J\t\u00106\u001a\u00020\u0003H\u00c6\u0003J\t\u00107\u001a\u00020\u0003H\u00c6\u0003J\t\u00108\u001a\u00020\u0003H\u00c6\u0003J\t\u00109\u001a\u00020\u0003H\u00c6\u0003J\t\u0010:\u001a\u00020\u0003H\u00c6\u0003J\t\u0010;\u001a\u00020\u0003H\u00c6\u0003J\t\u0010<\u001a\u00020\u0003H\u00c6\u0003J\u00bd\u0001\u0010=\u001a\u00020\u00002\u0008\u0008\u0002\u0010\u0002\u001a\u00020\u00032\u0008\u0008\u0002\u0010\u0004\u001a\u00020\u00032\u0008\u0008\u0002\u0010\u0005\u001a\u00020\u00032\u0008\u0008\u0002\u0010\u0006\u001a\u00020\u00032\u0008\u0008\u0002\u0010\u0007\u001a\u00020\u00032\u0008\u0008\u0002\u0010\u0008\u001a\u00020\u00032\u0008\u0008\u0002\u0010\t\u001a\u00020\u00032\u0008\u0008\u0002\u0010\n\u001a\u00020\u00032\u0008\u0008\u0002\u0010\u000b\u001a\u00020\u00032\u0008\u0008\u0002\u0010\u000c\u001a\u00020\u00032\u0008\u0008\u0002\u0010\r\u001a\u00020\u00032\u0008\u0008\u0002\u0010\u000e\u001a\u00020\u000f2\u0008\u0008\u0002\u0010\u0010\u001a\u00020\u000f2\u0008\u0008\u0002\u0010\u0011\u001a\u00020\u00032\u0008\u0008\u0002\u0010\u0012\u001a\u00020\u000f2\u0008\u0008\u0002\u0010\u0013\u001a\u00020\u00032\u0008\u0008\u0002\u0010\u0014\u001a\u00020\u00032\u0008\u0008\u0002\u0010\u0015\u001a\u00020\u0003H\u00c6\u0001J\u0013\u0010>\u001a\u00020?2\u0008\u0010@\u001a\u0004\u0018\u00010\u0001H\u00d6\u0003J\t\u0010A\u001a\u00020\u000fH\u00d6\u0001J\t\u0010B\u001a\u00020\u0003H\u00d6\u0001R\u0011\u0010\u0015\u001a\u00020\u0003\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\u0017\u0010\u0018R\u0011\u0010\r\u001a\u00020\u0003\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\u0019\u0010\u0018R\u0011\u0010\u000b\u001a\u00020\u0003\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\u001a\u0010\u0018R\u0011\u0010\u0013\u001a\u00020\u0003\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\u001b\u0010\u0018R\u0011\u0010\u0005\u001a\u00020\u0003\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\u001c\u0010\u0018R\u0011\u0010\u0002\u001a\u00020\u0003\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\u001d\u0010\u0018R\u0011\u0010\u0008\u001a\u00020\u0003\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\u001e\u0010\u0018R\u0011\u0010\u0010\u001a\u00020\u000f\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\u001f\u0010 R\u0011\u0010\u0011\u001a\u00020\u0003\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008!\u0010\u0018R\u0011\u0010\u0012\u001a\u00020\u000f\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\"\u0010 R\u0011\u0010\u0007\u001a\u00020\u0003\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008#\u0010\u0018R\u0011\u0010\u0006\u001a\u00020\u0003\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008$\u0010\u0018R\u0011\u0010\u0014\u001a\u00020\u0003\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008%\u0010\u0018R\u0011\u0010\t\u001a\u00020\u0003\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008&\u0010\u0018R\u0011\u0010\n\u001a\u00020\u0003\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\'\u0010\u0018R\u0011\u0010\u000e\u001a\u00020\u000f\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008(\u0010 R\u0011\u0010\u0004\u001a\u00020\u0003\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008)\u0010\u0018R\u0011\u0010\u000c\u001a\u00020\u0003\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008*\u0010\u0018\u00a8\u0006C"
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;",
        "",
        "id",
        "",
        "recordScore",
        "faceImageUrl",
        "originalUrl",
        "longitude",
        "latitude",
        "personName",
        "personTag",
        "createdTime",
        "serviceProvider",
        "createdName",
        "recognitionType",
        "",
        "libraryModel",
        "libraryName",
        "libraryPersonCount",
        "deviceName",
        "personIdCard",
        "address",
        "(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;IILjava/lang/String;ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;)V",
        "getAddress",
        "()Ljava/lang/String;",
        "getCreatedName",
        "getCreatedTime",
        "getDeviceName",
        "getFaceImageUrl",
        "getId",
        "getLatitude",
        "getLibraryModel",
        "()I",
        "getLibraryName",
        "getLibraryPersonCount",
        "getLongitude",
        "getOriginalUrl",
        "getPersonIdCard",
        "getPersonName",
        "getPersonTag",
        "getRecognitionType",
        "getRecordScore",
        "getServiceProvider",
        "component1",
        "component10",
        "component11",
        "component12",
        "component13",
        "component14",
        "component15",
        "component16",
        "component17",
        "component18",
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
        "sdk-server_release"
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
.field private final address:Ljava/lang/String;

.field private final createdName:Ljava/lang/String;

.field private final createdTime:Ljava/lang/String;

.field private final deviceName:Ljava/lang/String;

.field private final faceImageUrl:Ljava/lang/String;

.field private final id:Ljava/lang/String;

.field private final latitude:Ljava/lang/String;

.field private final libraryModel:I

.field private final libraryName:Ljava/lang/String;

.field private final libraryPersonCount:I

.field private final longitude:Ljava/lang/String;

.field private final originalUrl:Ljava/lang/String;

.field private final personIdCard:Ljava/lang/String;

.field private final personName:Ljava/lang/String;

.field private final personTag:Ljava/lang/String;

.field private final recognitionType:I

.field private final recordScore:Ljava/lang/String;

.field private final serviceProvider:Ljava/lang/String;


# direct methods
.method public constructor <init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;IILjava/lang/String;ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 16
    .param p1, "id"    # Ljava/lang/String;
    .param p2, "recordScore"    # Ljava/lang/String;
    .param p3, "faceImageUrl"    # Ljava/lang/String;
    .param p4, "originalUrl"    # Ljava/lang/String;
    .param p5, "longitude"    # Ljava/lang/String;
    .param p6, "latitude"    # Ljava/lang/String;
    .param p7, "personName"    # Ljava/lang/String;
    .param p8, "personTag"    # Ljava/lang/String;
    .param p9, "createdTime"    # Ljava/lang/String;
    .param p10, "serviceProvider"    # Ljava/lang/String;
    .param p11, "createdName"    # Ljava/lang/String;
    .param p12, "recognitionType"    # I
    .param p13, "libraryModel"    # I
    .param p14, "libraryName"    # Ljava/lang/String;
    .param p15, "libraryPersonCount"    # I
    .param p16, "deviceName"    # Ljava/lang/String;
    .param p17, "personIdCard"    # Ljava/lang/String;
    .param p18, "address"    # Ljava/lang/String;

    move-object/from16 v0, p0

    move-object/from16 v1, p1

    move-object/from16 v2, p2

    move-object/from16 v3, p3

    move-object/from16 v4, p4

    move-object/from16 v5, p5

    move-object/from16 v6, p6

    move-object/from16 v7, p7

    move-object/from16 v8, p8

    move-object/from16 v9, p9

    move-object/from16 v10, p10

    move-object/from16 v11, p11

    move-object/from16 v12, p14

    move-object/from16 v13, p16

    move-object/from16 v14, p17

    move-object/from16 v15, p18

    const-string v0, "id"

    invoke-static {v1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "recordScore"

    invoke-static {v2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "faceImageUrl"

    invoke-static {v3, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "originalUrl"

    invoke-static {v4, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "longitude"

    invoke-static {v5, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "latitude"

    invoke-static {v6, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "personName"

    invoke-static {v7, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "personTag"

    invoke-static {v8, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "createdTime"

    invoke-static {v9, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string/jumbo v0, "serviceProvider"

    invoke-static {v10, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "createdName"

    invoke-static {v11, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "libraryName"

    invoke-static {v12, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "deviceName"

    invoke-static {v13, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "personIdCard"

    invoke-static {v14, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "address"

    invoke-static {v15, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 3
    invoke-direct/range {p0 .. p0}, Ljava/lang/Object;-><init>()V

    .line 4
    move-object/from16 v0, p0

    iput-object v1, v0, Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;->id:Ljava/lang/String;

    .line 5
    iput-object v2, v0, Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;->recordScore:Ljava/lang/String;

    .line 6
    iput-object v3, v0, Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;->faceImageUrl:Ljava/lang/String;

    .line 7
    iput-object v4, v0, Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;->originalUrl:Ljava/lang/String;

    .line 8
    iput-object v5, v0, Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;->longitude:Ljava/lang/String;

    .line 9
    iput-object v6, v0, Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;->latitude:Ljava/lang/String;

    .line 10
    iput-object v7, v0, Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;->personName:Ljava/lang/String;

    .line 11
    iput-object v8, v0, Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;->personTag:Ljava/lang/String;

    .line 12
    iput-object v9, v0, Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;->createdTime:Ljava/lang/String;

    .line 13
    iput-object v10, v0, Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;->serviceProvider:Ljava/lang/String;

    .line 14
    iput-object v11, v0, Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;->createdName:Ljava/lang/String;

    .line 15
    move/from16 v1, p12

    iput v1, v0, Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;->recognitionType:I

    .line 16
    move/from16 v1, p13

    iput v1, v0, Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;->libraryModel:I

    .line 17
    iput-object v12, v0, Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;->libraryName:Ljava/lang/String;

    .line 18
    move/from16 v1, p15

    iput v1, v0, Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;->libraryPersonCount:I

    .line 19
    iput-object v13, v0, Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;->deviceName:Ljava/lang/String;

    .line 20
    iput-object v14, v0, Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;->personIdCard:Ljava/lang/String;

    .line 21
    iput-object v15, v0, Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;->address:Ljava/lang/String;

    .line 3
    return-void
.end method

.method public static synthetic copy$default(Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;IILjava/lang/String;ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;ILjava/lang/Object;)Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;
    .locals 17

    move-object/from16 v0, p0

    move/from16 v1, p19

    and-int/lit8 v2, v1, 0x1

    if-eqz v2, :cond_0

    iget-object v2, v0, Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;->id:Ljava/lang/String;

    goto :goto_0

    :cond_0
    move-object/from16 v2, p1

    :goto_0
    and-int/lit8 v3, v1, 0x2

    if-eqz v3, :cond_1

    iget-object v3, v0, Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;->recordScore:Ljava/lang/String;

    goto :goto_1

    :cond_1
    move-object/from16 v3, p2

    :goto_1
    and-int/lit8 v4, v1, 0x4

    if-eqz v4, :cond_2

    iget-object v4, v0, Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;->faceImageUrl:Ljava/lang/String;

    goto :goto_2

    :cond_2
    move-object/from16 v4, p3

    :goto_2
    and-int/lit8 v5, v1, 0x8

    if-eqz v5, :cond_3

    iget-object v5, v0, Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;->originalUrl:Ljava/lang/String;

    goto :goto_3

    :cond_3
    move-object/from16 v5, p4

    :goto_3
    and-int/lit8 v6, v1, 0x10

    if-eqz v6, :cond_4

    iget-object v6, v0, Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;->longitude:Ljava/lang/String;

    goto :goto_4

    :cond_4
    move-object/from16 v6, p5

    :goto_4
    and-int/lit8 v7, v1, 0x20

    if-eqz v7, :cond_5

    iget-object v7, v0, Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;->latitude:Ljava/lang/String;

    goto :goto_5

    :cond_5
    move-object/from16 v7, p6

    :goto_5
    and-int/lit8 v8, v1, 0x40

    if-eqz v8, :cond_6

    iget-object v8, v0, Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;->personName:Ljava/lang/String;

    goto :goto_6

    :cond_6
    move-object/from16 v8, p7

    :goto_6
    and-int/lit16 v9, v1, 0x80

    if-eqz v9, :cond_7

    iget-object v9, v0, Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;->personTag:Ljava/lang/String;

    goto :goto_7

    :cond_7
    move-object/from16 v9, p8

    :goto_7
    and-int/lit16 v10, v1, 0x100

    if-eqz v10, :cond_8

    iget-object v10, v0, Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;->createdTime:Ljava/lang/String;

    goto :goto_8

    :cond_8
    move-object/from16 v10, p9

    :goto_8
    and-int/lit16 v11, v1, 0x200

    if-eqz v11, :cond_9

    iget-object v11, v0, Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;->serviceProvider:Ljava/lang/String;

    goto :goto_9

    :cond_9
    move-object/from16 v11, p10

    :goto_9
    and-int/lit16 v12, v1, 0x400

    if-eqz v12, :cond_a

    iget-object v12, v0, Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;->createdName:Ljava/lang/String;

    goto :goto_a

    :cond_a
    move-object/from16 v12, p11

    :goto_a
    and-int/lit16 v13, v1, 0x800

    if-eqz v13, :cond_b

    iget v13, v0, Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;->recognitionType:I

    goto :goto_b

    :cond_b
    move/from16 v13, p12

    :goto_b
    and-int/lit16 v14, v1, 0x1000

    if-eqz v14, :cond_c

    iget v14, v0, Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;->libraryModel:I

    goto :goto_c

    :cond_c
    move/from16 v14, p13

    :goto_c
    and-int/lit16 v15, v1, 0x2000

    if-eqz v15, :cond_d

    iget-object v15, v0, Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;->libraryName:Ljava/lang/String;

    goto :goto_d

    :cond_d
    move-object/from16 v15, p14

    :goto_d
    move-object/from16 p14, v15

    and-int/lit16 v15, v1, 0x4000

    if-eqz v15, :cond_e

    iget v15, v0, Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;->libraryPersonCount:I

    goto :goto_e

    :cond_e
    move/from16 v15, p15

    :goto_e
    const v16, 0x8000

    and-int v16, v1, v16

    move/from16 p15, v15

    if-eqz v16, :cond_f

    iget-object v15, v0, Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;->deviceName:Ljava/lang/String;

    goto :goto_f

    :cond_f
    move-object/from16 v15, p16

    :goto_f
    const/high16 v16, 0x10000

    and-int v16, v1, v16

    move-object/from16 p16, v15

    if-eqz v16, :cond_10

    iget-object v15, v0, Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;->personIdCard:Ljava/lang/String;

    goto :goto_10

    :cond_10
    move-object/from16 v15, p17

    :goto_10
    const/high16 v16, 0x20000

    and-int v1, v1, v16

    if-eqz v1, :cond_11

    iget-object v1, v0, Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;->address:Ljava/lang/String;

    goto :goto_11

    :cond_11
    move-object/from16 v1, p18

    :goto_11
    move-object/from16 p1, v2

    move-object/from16 p2, v3

    move-object/from16 p3, v4

    move-object/from16 p4, v5

    move-object/from16 p5, v6

    move-object/from16 p6, v7

    move-object/from16 p7, v8

    move-object/from16 p8, v9

    move-object/from16 p9, v10

    move-object/from16 p10, v11

    move-object/from16 p11, v12

    move/from16 p12, v13

    move/from16 p13, v14

    move-object/from16 p17, v15

    move-object/from16 p18, v1

    invoke-virtual/range {p0 .. p18}, Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;->copy(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;IILjava/lang/String;ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;

    move-result-object v0

    return-object v0
.end method


# virtual methods
.method public final component1()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;->id:Ljava/lang/String;

    return-object v0
.end method

.method public final component10()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;->serviceProvider:Ljava/lang/String;

    return-object v0
.end method

.method public final component11()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;->createdName:Ljava/lang/String;

    return-object v0
.end method

.method public final component12()I
    .locals 1

    iget v0, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;->recognitionType:I

    return v0
.end method

.method public final component13()I
    .locals 1

    iget v0, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;->libraryModel:I

    return v0
.end method

.method public final component14()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;->libraryName:Ljava/lang/String;

    return-object v0
.end method

.method public final component15()I
    .locals 1

    iget v0, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;->libraryPersonCount:I

    return v0
.end method

.method public final component16()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;->deviceName:Ljava/lang/String;

    return-object v0
.end method

.method public final component17()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;->personIdCard:Ljava/lang/String;

    return-object v0
.end method

.method public final component18()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;->address:Ljava/lang/String;

    return-object v0
.end method

.method public final component2()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;->recordScore:Ljava/lang/String;

    return-object v0
.end method

.method public final component3()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;->faceImageUrl:Ljava/lang/String;

    return-object v0
.end method

.method public final component4()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;->originalUrl:Ljava/lang/String;

    return-object v0
.end method

.method public final component5()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;->longitude:Ljava/lang/String;

    return-object v0
.end method

.method public final component6()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;->latitude:Ljava/lang/String;

    return-object v0
.end method

.method public final component7()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;->personName:Ljava/lang/String;

    return-object v0
.end method

.method public final component8()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;->personTag:Ljava/lang/String;

    return-object v0
.end method

.method public final component9()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;->createdTime:Ljava/lang/String;

    return-object v0
.end method

.method public final copy(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;IILjava/lang/String;ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;
    .locals 21

    move-object/from16 v1, p1

    move-object/from16 v2, p2

    move-object/from16 v3, p3

    move-object/from16 v4, p4

    move-object/from16 v5, p5

    move-object/from16 v6, p6

    move-object/from16 v7, p7

    move-object/from16 v8, p8

    move-object/from16 v9, p9

    move-object/from16 v10, p10

    move-object/from16 v11, p11

    move/from16 v12, p12

    move/from16 v13, p13

    move-object/from16 v14, p14

    move/from16 v15, p15

    move-object/from16 v16, p16

    move-object/from16 v17, p17

    move-object/from16 v18, p18

    const-string v0, "id"

    move-object/from16 v19, v1

    invoke-static {v1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "recordScore"

    move-object/from16 v1, p2

    invoke-static {v1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "faceImageUrl"

    move-object/from16 v1, p3

    invoke-static {v1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "originalUrl"

    move-object/from16 v1, p4

    invoke-static {v1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "longitude"

    move-object/from16 v1, p5

    invoke-static {v1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "latitude"

    move-object/from16 v1, p6

    invoke-static {v1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "personName"

    move-object/from16 v1, p7

    invoke-static {v1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "personTag"

    move-object/from16 v1, p8

    invoke-static {v1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "createdTime"

    move-object/from16 v1, p9

    invoke-static {v1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string/jumbo v0, "serviceProvider"

    move-object/from16 v1, p10

    invoke-static {v1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "createdName"

    move-object/from16 v1, p11

    invoke-static {v1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "libraryName"

    move-object/from16 v1, p14

    invoke-static {v1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "deviceName"

    move-object/from16 v1, p16

    invoke-static {v1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "personIdCard"

    move-object/from16 v1, p17

    invoke-static {v1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "address"

    move-object/from16 v1, p18

    invoke-static {v1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    new-instance v20, Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;

    move-object/from16 v0, v20

    move-object/from16 v1, v19

    invoke-direct/range {v0 .. v18}, Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;IILjava/lang/String;ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    return-object v20
.end method

.method public equals(Ljava/lang/Object;)Z
    .locals 5

    const/4 v0, 0x1

    if-ne p0, p1, :cond_0

    return v0

    :cond_0
    instance-of v1, p1, Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;

    const/4 v2, 0x0

    if-nez v1, :cond_1

    return v2

    :cond_1
    move-object v1, p1

    check-cast v1, Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;

    iget-object v3, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;->id:Ljava/lang/String;

    iget-object v4, v1, Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;->id:Ljava/lang/String;

    invoke-static {v3, v4}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_2

    return v2

    :cond_2
    iget-object v3, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;->recordScore:Ljava/lang/String;

    iget-object v4, v1, Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;->recordScore:Ljava/lang/String;

    invoke-static {v3, v4}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_3

    return v2

    :cond_3
    iget-object v3, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;->faceImageUrl:Ljava/lang/String;

    iget-object v4, v1, Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;->faceImageUrl:Ljava/lang/String;

    invoke-static {v3, v4}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_4

    return v2

    :cond_4
    iget-object v3, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;->originalUrl:Ljava/lang/String;

    iget-object v4, v1, Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;->originalUrl:Ljava/lang/String;

    invoke-static {v3, v4}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_5

    return v2

    :cond_5
    iget-object v3, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;->longitude:Ljava/lang/String;

    iget-object v4, v1, Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;->longitude:Ljava/lang/String;

    invoke-static {v3, v4}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_6

    return v2

    :cond_6
    iget-object v3, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;->latitude:Ljava/lang/String;

    iget-object v4, v1, Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;->latitude:Ljava/lang/String;

    invoke-static {v3, v4}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_7

    return v2

    :cond_7
    iget-object v3, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;->personName:Ljava/lang/String;

    iget-object v4, v1, Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;->personName:Ljava/lang/String;

    invoke-static {v3, v4}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_8

    return v2

    :cond_8
    iget-object v3, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;->personTag:Ljava/lang/String;

    iget-object v4, v1, Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;->personTag:Ljava/lang/String;

    invoke-static {v3, v4}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_9

    return v2

    :cond_9
    iget-object v3, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;->createdTime:Ljava/lang/String;

    iget-object v4, v1, Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;->createdTime:Ljava/lang/String;

    invoke-static {v3, v4}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_a

    return v2

    :cond_a
    iget-object v3, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;->serviceProvider:Ljava/lang/String;

    iget-object v4, v1, Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;->serviceProvider:Ljava/lang/String;

    invoke-static {v3, v4}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_b

    return v2

    :cond_b
    iget-object v3, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;->createdName:Ljava/lang/String;

    iget-object v4, v1, Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;->createdName:Ljava/lang/String;

    invoke-static {v3, v4}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_c

    return v2

    :cond_c
    iget v3, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;->recognitionType:I

    iget v4, v1, Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;->recognitionType:I

    if-eq v3, v4, :cond_d

    return v2

    :cond_d
    iget v3, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;->libraryModel:I

    iget v4, v1, Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;->libraryModel:I

    if-eq v3, v4, :cond_e

    return v2

    :cond_e
    iget-object v3, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;->libraryName:Ljava/lang/String;

    iget-object v4, v1, Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;->libraryName:Ljava/lang/String;

    invoke-static {v3, v4}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_f

    return v2

    :cond_f
    iget v3, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;->libraryPersonCount:I

    iget v4, v1, Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;->libraryPersonCount:I

    if-eq v3, v4, :cond_10

    return v2

    :cond_10
    iget-object v3, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;->deviceName:Ljava/lang/String;

    iget-object v4, v1, Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;->deviceName:Ljava/lang/String;

    invoke-static {v3, v4}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_11

    return v2

    :cond_11
    iget-object v3, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;->personIdCard:Ljava/lang/String;

    iget-object v4, v1, Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;->personIdCard:Ljava/lang/String;

    invoke-static {v3, v4}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_12

    return v2

    :cond_12
    iget-object v3, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;->address:Ljava/lang/String;

    iget-object v1, v1, Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;->address:Ljava/lang/String;

    invoke-static {v3, v1}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_13

    return v2

    :cond_13
    return v0
.end method

.method public final getAddress()Ljava/lang/String;
    .locals 1

    .line 21
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;->address:Ljava/lang/String;

    return-object v0
.end method

.method public final getCreatedName()Ljava/lang/String;
    .locals 1

    .line 14
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;->createdName:Ljava/lang/String;

    return-object v0
.end method

.method public final getCreatedTime()Ljava/lang/String;
    .locals 1

    .line 12
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;->createdTime:Ljava/lang/String;

    return-object v0
.end method

.method public final getDeviceName()Ljava/lang/String;
    .locals 1

    .line 19
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;->deviceName:Ljava/lang/String;

    return-object v0
.end method

.method public final getFaceImageUrl()Ljava/lang/String;
    .locals 1

    .line 6
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;->faceImageUrl:Ljava/lang/String;

    return-object v0
.end method

.method public final getId()Ljava/lang/String;
    .locals 1

    .line 4
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;->id:Ljava/lang/String;

    return-object v0
.end method

.method public final getLatitude()Ljava/lang/String;
    .locals 1

    .line 9
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;->latitude:Ljava/lang/String;

    return-object v0
.end method

.method public final getLibraryModel()I
    .locals 1

    .line 16
    iget v0, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;->libraryModel:I

    return v0
.end method

.method public final getLibraryName()Ljava/lang/String;
    .locals 1

    .line 17
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;->libraryName:Ljava/lang/String;

    return-object v0
.end method

.method public final getLibraryPersonCount()I
    .locals 1

    .line 18
    iget v0, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;->libraryPersonCount:I

    return v0
.end method

.method public final getLongitude()Ljava/lang/String;
    .locals 1

    .line 8
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;->longitude:Ljava/lang/String;

    return-object v0
.end method

.method public final getOriginalUrl()Ljava/lang/String;
    .locals 1

    .line 7
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;->originalUrl:Ljava/lang/String;

    return-object v0
.end method

.method public final getPersonIdCard()Ljava/lang/String;
    .locals 1

    .line 20
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;->personIdCard:Ljava/lang/String;

    return-object v0
.end method

.method public final getPersonName()Ljava/lang/String;
    .locals 1

    .line 10
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;->personName:Ljava/lang/String;

    return-object v0
.end method

.method public final getPersonTag()Ljava/lang/String;
    .locals 1

    .line 11
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;->personTag:Ljava/lang/String;

    return-object v0
.end method

.method public final getRecognitionType()I
    .locals 1

    .line 15
    iget v0, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;->recognitionType:I

    return v0
.end method

.method public final getRecordScore()Ljava/lang/String;
    .locals 1

    .line 5
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;->recordScore:Ljava/lang/String;

    return-object v0
.end method

.method public final getServiceProvider()Ljava/lang/String;
    .locals 1

    .line 13
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;->serviceProvider:Ljava/lang/String;

    return-object v0
.end method

.method public hashCode()I
    .locals 3

    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;->id:Ljava/lang/String;

    invoke-virtual {v0}, Ljava/lang/String;->hashCode()I

    move-result v0

    mul-int/lit8 v1, v0, 0x1f

    iget-object v2, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;->recordScore:Ljava/lang/String;

    invoke-virtual {v2}, Ljava/lang/String;->hashCode()I

    move-result v2

    add-int/2addr v1, v2

    mul-int/lit8 v0, v1, 0x1f

    iget-object v2, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;->faceImageUrl:Ljava/lang/String;

    invoke-virtual {v2}, Ljava/lang/String;->hashCode()I

    move-result v2

    add-int/2addr v0, v2

    mul-int/lit8 v1, v0, 0x1f

    iget-object v2, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;->originalUrl:Ljava/lang/String;

    invoke-virtual {v2}, Ljava/lang/String;->hashCode()I

    move-result v2

    add-int/2addr v1, v2

    mul-int/lit8 v0, v1, 0x1f

    iget-object v2, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;->longitude:Ljava/lang/String;

    invoke-virtual {v2}, Ljava/lang/String;->hashCode()I

    move-result v2

    add-int/2addr v0, v2

    mul-int/lit8 v1, v0, 0x1f

    iget-object v2, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;->latitude:Ljava/lang/String;

    invoke-virtual {v2}, Ljava/lang/String;->hashCode()I

    move-result v2

    add-int/2addr v1, v2

    mul-int/lit8 v0, v1, 0x1f

    iget-object v2, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;->personName:Ljava/lang/String;

    invoke-virtual {v2}, Ljava/lang/String;->hashCode()I

    move-result v2

    add-int/2addr v0, v2

    mul-int/lit8 v1, v0, 0x1f

    iget-object v2, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;->personTag:Ljava/lang/String;

    invoke-virtual {v2}, Ljava/lang/String;->hashCode()I

    move-result v2

    add-int/2addr v1, v2

    mul-int/lit8 v0, v1, 0x1f

    iget-object v2, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;->createdTime:Ljava/lang/String;

    invoke-virtual {v2}, Ljava/lang/String;->hashCode()I

    move-result v2

    add-int/2addr v0, v2

    mul-int/lit8 v1, v0, 0x1f

    iget-object v2, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;->serviceProvider:Ljava/lang/String;

    invoke-virtual {v2}, Ljava/lang/String;->hashCode()I

    move-result v2

    add-int/2addr v1, v2

    mul-int/lit8 v0, v1, 0x1f

    iget-object v2, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;->createdName:Ljava/lang/String;

    invoke-virtual {v2}, Ljava/lang/String;->hashCode()I

    move-result v2

    add-int/2addr v0, v2

    mul-int/lit8 v1, v0, 0x1f

    iget v2, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;->recognitionType:I

    invoke-static {v2}, Ljava/lang/Integer;->hashCode(I)I

    move-result v2

    add-int/2addr v1, v2

    mul-int/lit8 v0, v1, 0x1f

    iget v2, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;->libraryModel:I

    invoke-static {v2}, Ljava/lang/Integer;->hashCode(I)I

    move-result v2

    add-int/2addr v0, v2

    mul-int/lit8 v1, v0, 0x1f

    iget-object v2, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;->libraryName:Ljava/lang/String;

    invoke-virtual {v2}, Ljava/lang/String;->hashCode()I

    move-result v2

    add-int/2addr v1, v2

    mul-int/lit8 v0, v1, 0x1f

    iget v2, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;->libraryPersonCount:I

    invoke-static {v2}, Ljava/lang/Integer;->hashCode(I)I

    move-result v2

    add-int/2addr v0, v2

    mul-int/lit8 v1, v0, 0x1f

    iget-object v2, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;->deviceName:Ljava/lang/String;

    invoke-virtual {v2}, Ljava/lang/String;->hashCode()I

    move-result v2

    add-int/2addr v1, v2

    mul-int/lit8 v0, v1, 0x1f

    iget-object v2, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;->personIdCard:Ljava/lang/String;

    invoke-virtual {v2}, Ljava/lang/String;->hashCode()I

    move-result v2

    add-int/2addr v0, v2

    mul-int/lit8 v1, v0, 0x1f

    iget-object v2, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;->address:Ljava/lang/String;

    invoke-virtual {v2}, Ljava/lang/String;->hashCode()I

    move-result v2

    add-int/2addr v1, v2

    return v1
.end method

.method public toString()Ljava/lang/String;
    .locals 3

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "RecognizedFaceInfo(id="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;->id:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ", recordScore="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;->recordScore:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ", faceImageUrl="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;->faceImageUrl:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ", originalUrl="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;->originalUrl:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ", longitude="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;->longitude:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ", latitude="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;->latitude:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ", personName="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;->personName:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ", personTag="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;->personTag:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ", createdTime="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;->createdTime:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ", serviceProvider="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;->serviceProvider:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ", createdName="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;->createdName:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ", recognitionType="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget v1, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;->recognitionType:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ", libraryModel="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget v2, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;->libraryModel:I

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ", libraryName="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;->libraryName:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ", libraryPersonCount="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget v2, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;->libraryPersonCount:I

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ", deviceName="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;->deviceName:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ", personIdCard="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;->personIdCard:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ", address="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/param/RecognizedFaceInfo;->address:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const/16 v2, 0x29

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
