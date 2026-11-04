.class public final Lcom/rokid/security/sdk/base/common/outside/Config;
.super Ljava/lang/Object;
.source "Config.kt"

# interfaces
.implements Landroid/os/Parcelable;


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000P\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0008\n\u0000\n\u0002\u0010\u000e\n\u0002\u0008\u0003\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0002\u0008#\n\u0002\u0010\u000b\n\u0000\n\u0002\u0010\u0000\n\u0002\u0008\u0003\n\u0002\u0010\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0002\u0008\u0087\u0008\u0018\u00002\u00020\u0001B\u00df\u0001\u0012\u0008\u0008\u0002\u0010\u0002\u001a\u00020\u0003\u0012\u0008\u0008\u0002\u0010\u0004\u001a\u00020\u0005\u0012\u0008\u0008\u0002\u0010\u0006\u001a\u00020\u0005\u0012\u0008\u0008\u0002\u0010\u0007\u001a\u00020\u0005\u0012\u0018\u0008\u0002\u0010\u0008\u001a\u0012\u0012\u0004\u0012\u00020\u00050\tj\u0008\u0012\u0004\u0012\u00020\u0005`\n\u0012\u0018\u0008\u0002\u0010\u000b\u001a\u0012\u0012\u0004\u0012\u00020\u00050\tj\u0008\u0012\u0004\u0012\u00020\u0005`\n\u0012\u0018\u0008\u0002\u0010\u000c\u001a\u0012\u0012\u0004\u0012\u00020\r0\tj\u0008\u0012\u0004\u0012\u00020\r`\n\u0012\u0008\u0008\u0002\u0010\u000e\u001a\u00020\u0003\u0012\u0018\u0008\u0002\u0010\u000f\u001a\u0012\u0012\u0004\u0012\u00020\u00100\tj\u0008\u0012\u0004\u0012\u00020\u0010`\n\u0012\u0018\u0008\u0002\u0010\u0011\u001a\u0012\u0012\u0004\u0012\u00020\u00100\tj\u0008\u0012\u0004\u0012\u00020\u0010`\n\u0012\u0018\u0008\u0002\u0010\u0012\u001a\u0012\u0012\u0004\u0012\u00020\u00100\tj\u0008\u0012\u0004\u0012\u00020\u0010`\n\u0012\n\u0008\u0002\u0010\u0013\u001a\u0004\u0018\u00010\u0010\u00a2\u0006\u0002\u0010\u0014J\t\u0010%\u001a\u00020\u0003H\u00c6\u0003J\u0019\u0010&\u001a\u0012\u0012\u0004\u0012\u00020\u00100\tj\u0008\u0012\u0004\u0012\u00020\u0010`\nH\u00c6\u0003J\u0019\u0010\'\u001a\u0012\u0012\u0004\u0012\u00020\u00100\tj\u0008\u0012\u0004\u0012\u00020\u0010`\nH\u00c6\u0003J\u000b\u0010(\u001a\u0004\u0018\u00010\u0010H\u00c6\u0003J\t\u0010)\u001a\u00020\u0005H\u00c6\u0003J\t\u0010*\u001a\u00020\u0005H\u00c6\u0003J\t\u0010+\u001a\u00020\u0005H\u00c6\u0003J\u0019\u0010,\u001a\u0012\u0012\u0004\u0012\u00020\u00050\tj\u0008\u0012\u0004\u0012\u00020\u0005`\nH\u00c6\u0003J\u0019\u0010-\u001a\u0012\u0012\u0004\u0012\u00020\u00050\tj\u0008\u0012\u0004\u0012\u00020\u0005`\nH\u00c6\u0003J\u0019\u0010.\u001a\u0012\u0012\u0004\u0012\u00020\r0\tj\u0008\u0012\u0004\u0012\u00020\r`\nH\u00c6\u0003J\t\u0010/\u001a\u00020\u0003H\u00c6\u0003J\u0019\u00100\u001a\u0012\u0012\u0004\u0012\u00020\u00100\tj\u0008\u0012\u0004\u0012\u00020\u0010`\nH\u00c6\u0003J\u00e3\u0001\u00101\u001a\u00020\u00002\u0008\u0008\u0002\u0010\u0002\u001a\u00020\u00032\u0008\u0008\u0002\u0010\u0004\u001a\u00020\u00052\u0008\u0008\u0002\u0010\u0006\u001a\u00020\u00052\u0008\u0008\u0002\u0010\u0007\u001a\u00020\u00052\u0018\u0008\u0002\u0010\u0008\u001a\u0012\u0012\u0004\u0012\u00020\u00050\tj\u0008\u0012\u0004\u0012\u00020\u0005`\n2\u0018\u0008\u0002\u0010\u000b\u001a\u0012\u0012\u0004\u0012\u00020\u00050\tj\u0008\u0012\u0004\u0012\u00020\u0005`\n2\u0018\u0008\u0002\u0010\u000c\u001a\u0012\u0012\u0004\u0012\u00020\r0\tj\u0008\u0012\u0004\u0012\u00020\r`\n2\u0008\u0008\u0002\u0010\u000e\u001a\u00020\u00032\u0018\u0008\u0002\u0010\u000f\u001a\u0012\u0012\u0004\u0012\u00020\u00100\tj\u0008\u0012\u0004\u0012\u00020\u0010`\n2\u0018\u0008\u0002\u0010\u0011\u001a\u0012\u0012\u0004\u0012\u00020\u00100\tj\u0008\u0012\u0004\u0012\u00020\u0010`\n2\u0018\u0008\u0002\u0010\u0012\u001a\u0012\u0012\u0004\u0012\u00020\u00100\tj\u0008\u0012\u0004\u0012\u00020\u0010`\n2\n\u0008\u0002\u0010\u0013\u001a\u0004\u0018\u00010\u0010H\u00c6\u0001J\t\u00102\u001a\u00020\u0003H\u00d6\u0001J\u0013\u00103\u001a\u0002042\u0008\u00105\u001a\u0004\u0018\u000106H\u00d6\u0003J\t\u00107\u001a\u00020\u0003H\u00d6\u0001J\t\u00108\u001a\u00020\u0005H\u00d6\u0001J\u0019\u00109\u001a\u00020:2\u0006\u0010;\u001a\u00020<2\u0006\u0010=\u001a\u00020\u0003H\u00d6\u0001R\u0011\u0010\u000e\u001a\u00020\u0003\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\u0015\u0010\u0016R\u0013\u0010\u0013\u001a\u0004\u0018\u00010\u0010\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\u0017\u0010\u0018R\u0011\u0010\u0002\u001a\u00020\u0003\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\u0019\u0010\u0016R\u0011\u0010\u0006\u001a\u00020\u0005\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\u001a\u0010\u001bR!\u0010\u000b\u001a\u0012\u0012\u0004\u0012\u00020\u00050\tj\u0008\u0012\u0004\u0012\u00020\u0005`\n\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\u001c\u0010\u001dR!\u0010\u0011\u001a\u0012\u0012\u0004\u0012\u00020\u00100\tj\u0008\u0012\u0004\u0012\u00020\u0010`\n\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\u001e\u0010\u001dR!\u0010\u0008\u001a\u0012\u0012\u0004\u0012\u00020\u00050\tj\u0008\u0012\u0004\u0012\u00020\u0005`\n\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\u001f\u0010\u001dR!\u0010\u000f\u001a\u0012\u0012\u0004\u0012\u00020\u00100\tj\u0008\u0012\u0004\u0012\u00020\u0010`\n\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008 \u0010\u001dR!\u0010\u0012\u001a\u0012\u0012\u0004\u0012\u00020\u00100\tj\u0008\u0012\u0004\u0012\u00020\u0010`\n\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008!\u0010\u001dR\u0011\u0010\u0007\u001a\u00020\u0005\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\"\u0010\u001bR\u0011\u0010\u0004\u001a\u00020\u0005\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008#\u0010\u001bR!\u0010\u000c\u001a\u0012\u0012\u0004\u0012\u00020\r0\tj\u0008\u0012\u0004\u0012\u00020\r`\n\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008$\u0010\u001d\u00a8\u0006>"
    }
    d2 = {
        "Lcom/rokid/security/sdk/base/common/outside/Config;",
        "Landroid/os/Parcelable;",
        "configVersion",
        "",
        "updateScope",
        "",
        "envType",
        "title",
        "showToHide",
        "Ljava/util/ArrayList;",
        "Lkotlin/collections/ArrayList;",
        "hideToShow",
        "voiceAction",
        "Lcom/rokid/security/sdk/base/common/outside/VoiceAction;",
        "adb",
        "showToHideApps",
        "Lcom/rokid/security/sdk/base/common/outside/AppConfigInfo;",
        "hideToShowApps",
        "thirdApps",
        "bootupApp",
        "(ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/util/ArrayList;Ljava/util/ArrayList;Ljava/util/ArrayList;ILjava/util/ArrayList;Ljava/util/ArrayList;Ljava/util/ArrayList;Lcom/rokid/security/sdk/base/common/outside/AppConfigInfo;)V",
        "getAdb",
        "()I",
        "getBootupApp",
        "()Lcom/rokid/security/sdk/base/common/outside/AppConfigInfo;",
        "getConfigVersion",
        "getEnvType",
        "()Ljava/lang/String;",
        "getHideToShow",
        "()Ljava/util/ArrayList;",
        "getHideToShowApps",
        "getShowToHide",
        "getShowToHideApps",
        "getThirdApps",
        "getTitle",
        "getUpdateScope",
        "getVoiceAction",
        "component1",
        "component10",
        "component11",
        "component12",
        "component2",
        "component3",
        "component4",
        "component5",
        "component6",
        "component7",
        "component8",
        "component9",
        "copy",
        "describeContents",
        "equals",
        "",
        "other",
        "",
        "hashCode",
        "toString",
        "writeToParcel",
        "",
        "parcel",
        "Landroid/os/Parcel;",
        "flags",
        "sdk-base-common_release"
    }
    k = 0x1
    mv = {
        0x1,
        0x8,
        0x0
    }
    xi = 0x30
.end annotation


# static fields
.field public static final CREATOR:Landroid/os/Parcelable$Creator;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Landroid/os/Parcelable$Creator<",
            "Lcom/rokid/security/sdk/base/common/outside/Config;",
            ">;"
        }
    .end annotation
.end field


# instance fields
.field private final adb:I

.field private final bootupApp:Lcom/rokid/security/sdk/base/common/outside/AppConfigInfo;

.field private final configVersion:I

.field private final envType:Ljava/lang/String;

.field private final hideToShow:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private final hideToShowApps:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList<",
            "Lcom/rokid/security/sdk/base/common/outside/AppConfigInfo;",
            ">;"
        }
    .end annotation
.end field

.field private final showToHide:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private final showToHideApps:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList<",
            "Lcom/rokid/security/sdk/base/common/outside/AppConfigInfo;",
            ">;"
        }
    .end annotation
.end field

.field private final thirdApps:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList<",
            "Lcom/rokid/security/sdk/base/common/outside/AppConfigInfo;",
            ">;"
        }
    .end annotation
.end field

.field private final title:Ljava/lang/String;

.field private final updateScope:Ljava/lang/String;

.field private final voiceAction:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList<",
            "Lcom/rokid/security/sdk/base/common/outside/VoiceAction;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Lcom/rokid/security/sdk/base/common/outside/Config$Creator;

    invoke-direct {v0}, Lcom/rokid/security/sdk/base/common/outside/Config$Creator;-><init>()V

    check-cast v0, Landroid/os/Parcelable$Creator;

    sput-object v0, Lcom/rokid/security/sdk/base/common/outside/Config;->CREATOR:Landroid/os/Parcelable$Creator;

    return-void
.end method

.method public constructor <init>()V
    .locals 15

    const/16 v13, 0xfff

    const/4 v14, 0x0

    const/4 v1, 0x0

    const/4 v2, 0x0

    const/4 v3, 0x0

    const/4 v4, 0x0

    const/4 v5, 0x0

    const/4 v6, 0x0

    const/4 v7, 0x0

    const/4 v8, 0x0

    const/4 v9, 0x0

    const/4 v10, 0x0

    const/4 v11, 0x0

    const/4 v12, 0x0

    move-object v0, p0

    invoke-direct/range {v0 .. v14}, Lcom/rokid/security/sdk/base/common/outside/Config;-><init>(ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/util/ArrayList;Ljava/util/ArrayList;Ljava/util/ArrayList;ILjava/util/ArrayList;Ljava/util/ArrayList;Ljava/util/ArrayList;Lcom/rokid/security/sdk/base/common/outside/AppConfigInfo;ILkotlin/jvm/internal/DefaultConstructorMarker;)V

    return-void
.end method

.method public constructor <init>(ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/util/ArrayList;Ljava/util/ArrayList;Ljava/util/ArrayList;ILjava/util/ArrayList;Ljava/util/ArrayList;Ljava/util/ArrayList;Lcom/rokid/security/sdk/base/common/outside/AppConfigInfo;)V
    .locals 1
    .param p1, "configVersion"    # I
    .param p2, "updateScope"    # Ljava/lang/String;
    .param p3, "envType"    # Ljava/lang/String;
    .param p4, "title"    # Ljava/lang/String;
    .param p5, "showToHide"    # Ljava/util/ArrayList;
    .param p6, "hideToShow"    # Ljava/util/ArrayList;
    .param p7, "voiceAction"    # Ljava/util/ArrayList;
    .param p8, "adb"    # I
    .param p9, "showToHideApps"    # Ljava/util/ArrayList;
    .param p10, "hideToShowApps"    # Ljava/util/ArrayList;
    .param p11, "thirdApps"    # Ljava/util/ArrayList;
    .param p12, "bootupApp"    # Lcom/rokid/security/sdk/base/common/outside/AppConfigInfo;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(I",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/util/ArrayList<",
            "Ljava/lang/String;",
            ">;",
            "Ljava/util/ArrayList<",
            "Ljava/lang/String;",
            ">;",
            "Ljava/util/ArrayList<",
            "Lcom/rokid/security/sdk/base/common/outside/VoiceAction;",
            ">;I",
            "Ljava/util/ArrayList<",
            "Lcom/rokid/security/sdk/base/common/outside/AppConfigInfo;",
            ">;",
            "Ljava/util/ArrayList<",
            "Lcom/rokid/security/sdk/base/common/outside/AppConfigInfo;",
            ">;",
            "Ljava/util/ArrayList<",
            "Lcom/rokid/security/sdk/base/common/outside/AppConfigInfo;",
            ">;",
            "Lcom/rokid/security/sdk/base/common/outside/AppConfigInfo;",
            ")V"
        }
    .end annotation

    const-string/jumbo v0, "updateScope"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "envType"

    invoke-static {p3, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string/jumbo v0, "title"

    invoke-static {p4, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string/jumbo v0, "showToHide"

    invoke-static {p5, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "hideToShow"

    invoke-static {p6, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string/jumbo v0, "voiceAction"

    invoke-static {p7, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string/jumbo v0, "showToHideApps"

    invoke-static {p9, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "hideToShowApps"

    invoke-static {p10, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string/jumbo v0, "thirdApps"

    invoke-static {p11, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 11
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 14
    iput p1, p0, Lcom/rokid/security/sdk/base/common/outside/Config;->configVersion:I

    .line 15
    iput-object p2, p0, Lcom/rokid/security/sdk/base/common/outside/Config;->updateScope:Ljava/lang/String;

    .line 16
    iput-object p3, p0, Lcom/rokid/security/sdk/base/common/outside/Config;->envType:Ljava/lang/String;

    .line 17
    iput-object p4, p0, Lcom/rokid/security/sdk/base/common/outside/Config;->title:Ljava/lang/String;

    .line 19
    iput-object p5, p0, Lcom/rokid/security/sdk/base/common/outside/Config;->showToHide:Ljava/util/ArrayList;

    .line 20
    iput-object p6, p0, Lcom/rokid/security/sdk/base/common/outside/Config;->hideToShow:Ljava/util/ArrayList;

    .line 22
    iput-object p7, p0, Lcom/rokid/security/sdk/base/common/outside/Config;->voiceAction:Ljava/util/ArrayList;

    .line 24
    iput p8, p0, Lcom/rokid/security/sdk/base/common/outside/Config;->adb:I

    .line 26
    iput-object p9, p0, Lcom/rokid/security/sdk/base/common/outside/Config;->showToHideApps:Ljava/util/ArrayList;

    .line 27
    iput-object p10, p0, Lcom/rokid/security/sdk/base/common/outside/Config;->hideToShowApps:Ljava/util/ArrayList;

    .line 28
    iput-object p11, p0, Lcom/rokid/security/sdk/base/common/outside/Config;->thirdApps:Ljava/util/ArrayList;

    .line 30
    iput-object p12, p0, Lcom/rokid/security/sdk/base/common/outside/Config;->bootupApp:Lcom/rokid/security/sdk/base/common/outside/AppConfigInfo;

    .line 13
    return-void
.end method

.method public synthetic constructor <init>(ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/util/ArrayList;Ljava/util/ArrayList;Ljava/util/ArrayList;ILjava/util/ArrayList;Ljava/util/ArrayList;Ljava/util/ArrayList;Lcom/rokid/security/sdk/base/common/outside/AppConfigInfo;ILkotlin/jvm/internal/DefaultConstructorMarker;)V
    .locals 12

    .line 13
    move/from16 v0, p13

    and-int/lit8 v1, v0, 0x1

    if-eqz v1, :cond_0

    .line 14
    const/4 v1, 0x1

    goto :goto_0

    .line 13
    :cond_0
    move v1, p1

    :goto_0
    and-int/lit8 v2, v0, 0x2

    const-string v3, ""

    if-eqz v2, :cond_1

    .line 15
    move-object v2, v3

    goto :goto_1

    .line 13
    :cond_1
    move-object v2, p2

    :goto_1
    and-int/lit8 v4, v0, 0x4

    if-eqz v4, :cond_2

    .line 16
    move-object v4, v3

    goto :goto_2

    .line 13
    :cond_2
    move-object v4, p3

    :goto_2
    and-int/lit8 v5, v0, 0x8

    if-eqz v5, :cond_3

    .line 17
    goto :goto_3

    .line 13
    :cond_3
    move-object/from16 v3, p4

    :goto_3
    and-int/lit8 v5, v0, 0x10

    if-eqz v5, :cond_4

    .line 19
    new-instance v5, Ljava/util/ArrayList;

    invoke-direct {v5}, Ljava/util/ArrayList;-><init>()V

    goto :goto_4

    .line 13
    :cond_4
    move-object/from16 v5, p5

    :goto_4
    and-int/lit8 v6, v0, 0x20

    if-eqz v6, :cond_5

    .line 20
    new-instance v6, Ljava/util/ArrayList;

    invoke-direct {v6}, Ljava/util/ArrayList;-><init>()V

    goto :goto_5

    .line 13
    :cond_5
    move-object/from16 v6, p6

    :goto_5
    and-int/lit8 v7, v0, 0x40

    if-eqz v7, :cond_6

    .line 22
    new-instance v7, Ljava/util/ArrayList;

    invoke-direct {v7}, Ljava/util/ArrayList;-><init>()V

    goto :goto_6

    .line 13
    :cond_6
    move-object/from16 v7, p7

    :goto_6
    and-int/lit16 v8, v0, 0x80

    if-eqz v8, :cond_7

    .line 24
    const/4 v8, -0x1

    goto :goto_7

    .line 13
    :cond_7
    move/from16 v8, p8

    :goto_7
    and-int/lit16 v9, v0, 0x100

    if-eqz v9, :cond_8

    .line 26
    new-instance v9, Ljava/util/ArrayList;

    invoke-direct {v9}, Ljava/util/ArrayList;-><init>()V

    goto :goto_8

    .line 13
    :cond_8
    move-object/from16 v9, p9

    :goto_8
    and-int/lit16 v10, v0, 0x200

    if-eqz v10, :cond_9

    .line 27
    new-instance v10, Ljava/util/ArrayList;

    invoke-direct {v10}, Ljava/util/ArrayList;-><init>()V

    goto :goto_9

    .line 13
    :cond_9
    move-object/from16 v10, p10

    :goto_9
    and-int/lit16 v11, v0, 0x400

    if-eqz v11, :cond_a

    .line 28
    new-instance v11, Ljava/util/ArrayList;

    invoke-direct {v11}, Ljava/util/ArrayList;-><init>()V

    goto :goto_a

    .line 13
    :cond_a
    move-object/from16 v11, p11

    :goto_a
    and-int/lit16 v0, v0, 0x800

    if-eqz v0, :cond_b

    .line 30
    const/4 v0, 0x0

    goto :goto_b

    .line 13
    :cond_b
    move-object/from16 v0, p12

    :goto_b
    move-object p1, p0

    move p2, v1

    move-object p3, v2

    move-object/from16 p4, v4

    move-object/from16 p5, v3

    move-object/from16 p6, v5

    move-object/from16 p7, v6

    move-object/from16 p8, v7

    move/from16 p9, v8

    move-object/from16 p10, v9

    move-object/from16 p11, v10

    move-object/from16 p12, v11

    move-object/from16 p13, v0

    invoke-direct/range {p1 .. p13}, Lcom/rokid/security/sdk/base/common/outside/Config;-><init>(ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/util/ArrayList;Ljava/util/ArrayList;Ljava/util/ArrayList;ILjava/util/ArrayList;Ljava/util/ArrayList;Ljava/util/ArrayList;Lcom/rokid/security/sdk/base/common/outside/AppConfigInfo;)V

    .line 31
    return-void
.end method

.method public static synthetic copy$default(Lcom/rokid/security/sdk/base/common/outside/Config;ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/util/ArrayList;Ljava/util/ArrayList;Ljava/util/ArrayList;ILjava/util/ArrayList;Ljava/util/ArrayList;Ljava/util/ArrayList;Lcom/rokid/security/sdk/base/common/outside/AppConfigInfo;ILjava/lang/Object;)Lcom/rokid/security/sdk/base/common/outside/Config;
    .locals 13

    move-object v0, p0

    move/from16 v1, p13

    and-int/lit8 v2, v1, 0x1

    if-eqz v2, :cond_0

    iget v2, v0, Lcom/rokid/security/sdk/base/common/outside/Config;->configVersion:I

    goto :goto_0

    :cond_0
    move v2, p1

    :goto_0
    and-int/lit8 v3, v1, 0x2

    if-eqz v3, :cond_1

    iget-object v3, v0, Lcom/rokid/security/sdk/base/common/outside/Config;->updateScope:Ljava/lang/String;

    goto :goto_1

    :cond_1
    move-object v3, p2

    :goto_1
    and-int/lit8 v4, v1, 0x4

    if-eqz v4, :cond_2

    iget-object v4, v0, Lcom/rokid/security/sdk/base/common/outside/Config;->envType:Ljava/lang/String;

    goto :goto_2

    :cond_2
    move-object/from16 v4, p3

    :goto_2
    and-int/lit8 v5, v1, 0x8

    if-eqz v5, :cond_3

    iget-object v5, v0, Lcom/rokid/security/sdk/base/common/outside/Config;->title:Ljava/lang/String;

    goto :goto_3

    :cond_3
    move-object/from16 v5, p4

    :goto_3
    and-int/lit8 v6, v1, 0x10

    if-eqz v6, :cond_4

    iget-object v6, v0, Lcom/rokid/security/sdk/base/common/outside/Config;->showToHide:Ljava/util/ArrayList;

    goto :goto_4

    :cond_4
    move-object/from16 v6, p5

    :goto_4
    and-int/lit8 v7, v1, 0x20

    if-eqz v7, :cond_5

    iget-object v7, v0, Lcom/rokid/security/sdk/base/common/outside/Config;->hideToShow:Ljava/util/ArrayList;

    goto :goto_5

    :cond_5
    move-object/from16 v7, p6

    :goto_5
    and-int/lit8 v8, v1, 0x40

    if-eqz v8, :cond_6

    iget-object v8, v0, Lcom/rokid/security/sdk/base/common/outside/Config;->voiceAction:Ljava/util/ArrayList;

    goto :goto_6

    :cond_6
    move-object/from16 v8, p7

    :goto_6
    and-int/lit16 v9, v1, 0x80

    if-eqz v9, :cond_7

    iget v9, v0, Lcom/rokid/security/sdk/base/common/outside/Config;->adb:I

    goto :goto_7

    :cond_7
    move/from16 v9, p8

    :goto_7
    and-int/lit16 v10, v1, 0x100

    if-eqz v10, :cond_8

    iget-object v10, v0, Lcom/rokid/security/sdk/base/common/outside/Config;->showToHideApps:Ljava/util/ArrayList;

    goto :goto_8

    :cond_8
    move-object/from16 v10, p9

    :goto_8
    and-int/lit16 v11, v1, 0x200

    if-eqz v11, :cond_9

    iget-object v11, v0, Lcom/rokid/security/sdk/base/common/outside/Config;->hideToShowApps:Ljava/util/ArrayList;

    goto :goto_9

    :cond_9
    move-object/from16 v11, p10

    :goto_9
    and-int/lit16 v12, v1, 0x400

    if-eqz v12, :cond_a

    iget-object v12, v0, Lcom/rokid/security/sdk/base/common/outside/Config;->thirdApps:Ljava/util/ArrayList;

    goto :goto_a

    :cond_a
    move-object/from16 v12, p11

    :goto_a
    and-int/lit16 v1, v1, 0x800

    if-eqz v1, :cond_b

    iget-object v1, v0, Lcom/rokid/security/sdk/base/common/outside/Config;->bootupApp:Lcom/rokid/security/sdk/base/common/outside/AppConfigInfo;

    goto :goto_b

    :cond_b
    move-object/from16 v1, p12

    :goto_b
    move p1, v2

    move-object p2, v3

    move-object/from16 p3, v4

    move-object/from16 p4, v5

    move-object/from16 p5, v6

    move-object/from16 p6, v7

    move-object/from16 p7, v8

    move/from16 p8, v9

    move-object/from16 p9, v10

    move-object/from16 p10, v11

    move-object/from16 p11, v12

    move-object/from16 p12, v1

    invoke-virtual/range {p0 .. p12}, Lcom/rokid/security/sdk/base/common/outside/Config;->copy(ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/util/ArrayList;Ljava/util/ArrayList;Ljava/util/ArrayList;ILjava/util/ArrayList;Ljava/util/ArrayList;Ljava/util/ArrayList;Lcom/rokid/security/sdk/base/common/outside/AppConfigInfo;)Lcom/rokid/security/sdk/base/common/outside/Config;

    move-result-object v0

    return-object v0
.end method


# virtual methods
.method public final component1()I
    .locals 1

    iget v0, p0, Lcom/rokid/security/sdk/base/common/outside/Config;->configVersion:I

    return v0
.end method

.method public final component10()Ljava/util/ArrayList;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/ArrayList<",
            "Lcom/rokid/security/sdk/base/common/outside/AppConfigInfo;",
            ">;"
        }
    .end annotation

    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/outside/Config;->hideToShowApps:Ljava/util/ArrayList;

    return-object v0
.end method

.method public final component11()Ljava/util/ArrayList;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/ArrayList<",
            "Lcom/rokid/security/sdk/base/common/outside/AppConfigInfo;",
            ">;"
        }
    .end annotation

    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/outside/Config;->thirdApps:Ljava/util/ArrayList;

    return-object v0
.end method

.method public final component12()Lcom/rokid/security/sdk/base/common/outside/AppConfigInfo;
    .locals 1

    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/outside/Config;->bootupApp:Lcom/rokid/security/sdk/base/common/outside/AppConfigInfo;

    return-object v0
.end method

.method public final component2()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/outside/Config;->updateScope:Ljava/lang/String;

    return-object v0
.end method

.method public final component3()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/outside/Config;->envType:Ljava/lang/String;

    return-object v0
.end method

.method public final component4()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/outside/Config;->title:Ljava/lang/String;

    return-object v0
.end method

.method public final component5()Ljava/util/ArrayList;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/ArrayList<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/outside/Config;->showToHide:Ljava/util/ArrayList;

    return-object v0
.end method

.method public final component6()Ljava/util/ArrayList;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/ArrayList<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/outside/Config;->hideToShow:Ljava/util/ArrayList;

    return-object v0
.end method

.method public final component7()Ljava/util/ArrayList;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/ArrayList<",
            "Lcom/rokid/security/sdk/base/common/outside/VoiceAction;",
            ">;"
        }
    .end annotation

    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/outside/Config;->voiceAction:Ljava/util/ArrayList;

    return-object v0
.end method

.method public final component8()I
    .locals 1

    iget v0, p0, Lcom/rokid/security/sdk/base/common/outside/Config;->adb:I

    return v0
.end method

.method public final component9()Ljava/util/ArrayList;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/ArrayList<",
            "Lcom/rokid/security/sdk/base/common/outside/AppConfigInfo;",
            ">;"
        }
    .end annotation

    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/outside/Config;->showToHideApps:Ljava/util/ArrayList;

    return-object v0
.end method

.method public final copy(ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/util/ArrayList;Ljava/util/ArrayList;Ljava/util/ArrayList;ILjava/util/ArrayList;Ljava/util/ArrayList;Ljava/util/ArrayList;Lcom/rokid/security/sdk/base/common/outside/AppConfigInfo;)Lcom/rokid/security/sdk/base/common/outside/Config;
    .locals 16
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(I",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/util/ArrayList<",
            "Ljava/lang/String;",
            ">;",
            "Ljava/util/ArrayList<",
            "Ljava/lang/String;",
            ">;",
            "Ljava/util/ArrayList<",
            "Lcom/rokid/security/sdk/base/common/outside/VoiceAction;",
            ">;I",
            "Ljava/util/ArrayList<",
            "Lcom/rokid/security/sdk/base/common/outside/AppConfigInfo;",
            ">;",
            "Ljava/util/ArrayList<",
            "Lcom/rokid/security/sdk/base/common/outside/AppConfigInfo;",
            ">;",
            "Ljava/util/ArrayList<",
            "Lcom/rokid/security/sdk/base/common/outside/AppConfigInfo;",
            ">;",
            "Lcom/rokid/security/sdk/base/common/outside/AppConfigInfo;",
            ")",
            "Lcom/rokid/security/sdk/base/common/outside/Config;"
        }
    .end annotation

    const-string/jumbo v0, "updateScope"

    move-object/from16 v14, p2

    invoke-static {v14, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "envType"

    move-object/from16 v15, p3

    invoke-static {v15, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string/jumbo v0, "title"

    move-object/from16 v13, p4

    invoke-static {v13, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string/jumbo v0, "showToHide"

    move-object/from16 v12, p5

    invoke-static {v12, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "hideToShow"

    move-object/from16 v11, p6

    invoke-static {v11, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string/jumbo v0, "voiceAction"

    move-object/from16 v10, p7

    invoke-static {v10, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string/jumbo v0, "showToHideApps"

    move-object/from16 v9, p9

    invoke-static {v9, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "hideToShowApps"

    move-object/from16 v8, p10

    invoke-static {v8, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string/jumbo v0, "thirdApps"

    move-object/from16 v7, p11

    invoke-static {v7, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    new-instance v0, Lcom/rokid/security/sdk/base/common/outside/Config;

    move-object v1, v0

    move/from16 v2, p1

    move-object/from16 v3, p2

    move-object/from16 v4, p3

    move-object/from16 v5, p4

    move-object/from16 v6, p5

    move-object/from16 v7, p6

    move-object/from16 v8, p7

    move/from16 v9, p8

    move-object/from16 v10, p9

    move-object/from16 v11, p10

    move-object/from16 v12, p11

    move-object/from16 v13, p12

    invoke-direct/range {v1 .. v13}, Lcom/rokid/security/sdk/base/common/outside/Config;-><init>(ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/util/ArrayList;Ljava/util/ArrayList;Ljava/util/ArrayList;ILjava/util/ArrayList;Ljava/util/ArrayList;Ljava/util/ArrayList;Lcom/rokid/security/sdk/base/common/outside/AppConfigInfo;)V

    return-object v0
.end method

.method public describeContents()I
    .locals 1

    const/4 v0, 0x0

    return v0
.end method

.method public equals(Ljava/lang/Object;)Z
    .locals 5

    const/4 v0, 0x1

    if-ne p0, p1, :cond_0

    return v0

    :cond_0
    instance-of v1, p1, Lcom/rokid/security/sdk/base/common/outside/Config;

    const/4 v2, 0x0

    if-nez v1, :cond_1

    return v2

    :cond_1
    move-object v1, p1

    check-cast v1, Lcom/rokid/security/sdk/base/common/outside/Config;

    iget v3, p0, Lcom/rokid/security/sdk/base/common/outside/Config;->configVersion:I

    iget v4, v1, Lcom/rokid/security/sdk/base/common/outside/Config;->configVersion:I

    if-eq v3, v4, :cond_2

    return v2

    :cond_2
    iget-object v3, p0, Lcom/rokid/security/sdk/base/common/outside/Config;->updateScope:Ljava/lang/String;

    iget-object v4, v1, Lcom/rokid/security/sdk/base/common/outside/Config;->updateScope:Ljava/lang/String;

    invoke-static {v3, v4}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_3

    return v2

    :cond_3
    iget-object v3, p0, Lcom/rokid/security/sdk/base/common/outside/Config;->envType:Ljava/lang/String;

    iget-object v4, v1, Lcom/rokid/security/sdk/base/common/outside/Config;->envType:Ljava/lang/String;

    invoke-static {v3, v4}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_4

    return v2

    :cond_4
    iget-object v3, p0, Lcom/rokid/security/sdk/base/common/outside/Config;->title:Ljava/lang/String;

    iget-object v4, v1, Lcom/rokid/security/sdk/base/common/outside/Config;->title:Ljava/lang/String;

    invoke-static {v3, v4}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_5

    return v2

    :cond_5
    iget-object v3, p0, Lcom/rokid/security/sdk/base/common/outside/Config;->showToHide:Ljava/util/ArrayList;

    iget-object v4, v1, Lcom/rokid/security/sdk/base/common/outside/Config;->showToHide:Ljava/util/ArrayList;

    invoke-static {v3, v4}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_6

    return v2

    :cond_6
    iget-object v3, p0, Lcom/rokid/security/sdk/base/common/outside/Config;->hideToShow:Ljava/util/ArrayList;

    iget-object v4, v1, Lcom/rokid/security/sdk/base/common/outside/Config;->hideToShow:Ljava/util/ArrayList;

    invoke-static {v3, v4}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_7

    return v2

    :cond_7
    iget-object v3, p0, Lcom/rokid/security/sdk/base/common/outside/Config;->voiceAction:Ljava/util/ArrayList;

    iget-object v4, v1, Lcom/rokid/security/sdk/base/common/outside/Config;->voiceAction:Ljava/util/ArrayList;

    invoke-static {v3, v4}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_8

    return v2

    :cond_8
    iget v3, p0, Lcom/rokid/security/sdk/base/common/outside/Config;->adb:I

    iget v4, v1, Lcom/rokid/security/sdk/base/common/outside/Config;->adb:I

    if-eq v3, v4, :cond_9

    return v2

    :cond_9
    iget-object v3, p0, Lcom/rokid/security/sdk/base/common/outside/Config;->showToHideApps:Ljava/util/ArrayList;

    iget-object v4, v1, Lcom/rokid/security/sdk/base/common/outside/Config;->showToHideApps:Ljava/util/ArrayList;

    invoke-static {v3, v4}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_a

    return v2

    :cond_a
    iget-object v3, p0, Lcom/rokid/security/sdk/base/common/outside/Config;->hideToShowApps:Ljava/util/ArrayList;

    iget-object v4, v1, Lcom/rokid/security/sdk/base/common/outside/Config;->hideToShowApps:Ljava/util/ArrayList;

    invoke-static {v3, v4}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_b

    return v2

    :cond_b
    iget-object v3, p0, Lcom/rokid/security/sdk/base/common/outside/Config;->thirdApps:Ljava/util/ArrayList;

    iget-object v4, v1, Lcom/rokid/security/sdk/base/common/outside/Config;->thirdApps:Ljava/util/ArrayList;

    invoke-static {v3, v4}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_c

    return v2

    :cond_c
    iget-object v3, p0, Lcom/rokid/security/sdk/base/common/outside/Config;->bootupApp:Lcom/rokid/security/sdk/base/common/outside/AppConfigInfo;

    iget-object v1, v1, Lcom/rokid/security/sdk/base/common/outside/Config;->bootupApp:Lcom/rokid/security/sdk/base/common/outside/AppConfigInfo;

    invoke-static {v3, v1}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_d

    return v2

    :cond_d
    return v0
.end method

.method public final getAdb()I
    .locals 1

    .line 24
    iget v0, p0, Lcom/rokid/security/sdk/base/common/outside/Config;->adb:I

    return v0
.end method

.method public final getBootupApp()Lcom/rokid/security/sdk/base/common/outside/AppConfigInfo;
    .locals 1

    .line 30
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/outside/Config;->bootupApp:Lcom/rokid/security/sdk/base/common/outside/AppConfigInfo;

    return-object v0
.end method

.method public final getConfigVersion()I
    .locals 1

    .line 14
    iget v0, p0, Lcom/rokid/security/sdk/base/common/outside/Config;->configVersion:I

    return v0
.end method

.method public final getEnvType()Ljava/lang/String;
    .locals 1

    .line 16
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/outside/Config;->envType:Ljava/lang/String;

    return-object v0
.end method

.method public final getHideToShow()Ljava/util/ArrayList;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/ArrayList<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .line 20
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/outside/Config;->hideToShow:Ljava/util/ArrayList;

    return-object v0
.end method

.method public final getHideToShowApps()Ljava/util/ArrayList;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/ArrayList<",
            "Lcom/rokid/security/sdk/base/common/outside/AppConfigInfo;",
            ">;"
        }
    .end annotation

    .line 27
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/outside/Config;->hideToShowApps:Ljava/util/ArrayList;

    return-object v0
.end method

.method public final getShowToHide()Ljava/util/ArrayList;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/ArrayList<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .line 19
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/outside/Config;->showToHide:Ljava/util/ArrayList;

    return-object v0
.end method

.method public final getShowToHideApps()Ljava/util/ArrayList;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/ArrayList<",
            "Lcom/rokid/security/sdk/base/common/outside/AppConfigInfo;",
            ">;"
        }
    .end annotation

    .line 26
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/outside/Config;->showToHideApps:Ljava/util/ArrayList;

    return-object v0
.end method

.method public final getThirdApps()Ljava/util/ArrayList;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/ArrayList<",
            "Lcom/rokid/security/sdk/base/common/outside/AppConfigInfo;",
            ">;"
        }
    .end annotation

    .line 28
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/outside/Config;->thirdApps:Ljava/util/ArrayList;

    return-object v0
.end method

.method public final getTitle()Ljava/lang/String;
    .locals 1

    .line 17
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/outside/Config;->title:Ljava/lang/String;

    return-object v0
.end method

.method public final getUpdateScope()Ljava/lang/String;
    .locals 1

    .line 15
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/outside/Config;->updateScope:Ljava/lang/String;

    return-object v0
.end method

.method public final getVoiceAction()Ljava/util/ArrayList;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/ArrayList<",
            "Lcom/rokid/security/sdk/base/common/outside/VoiceAction;",
            ">;"
        }
    .end annotation

    .line 22
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/outside/Config;->voiceAction:Ljava/util/ArrayList;

    return-object v0
.end method

.method public hashCode()I
    .locals 3

    iget v0, p0, Lcom/rokid/security/sdk/base/common/outside/Config;->configVersion:I

    invoke-static {v0}, Ljava/lang/Integer;->hashCode(I)I

    move-result v0

    mul-int/lit8 v1, v0, 0x1f

    iget-object v2, p0, Lcom/rokid/security/sdk/base/common/outside/Config;->updateScope:Ljava/lang/String;

    invoke-virtual {v2}, Ljava/lang/String;->hashCode()I

    move-result v2

    add-int/2addr v1, v2

    mul-int/lit8 v0, v1, 0x1f

    iget-object v2, p0, Lcom/rokid/security/sdk/base/common/outside/Config;->envType:Ljava/lang/String;

    invoke-virtual {v2}, Ljava/lang/String;->hashCode()I

    move-result v2

    add-int/2addr v0, v2

    mul-int/lit8 v1, v0, 0x1f

    iget-object v2, p0, Lcom/rokid/security/sdk/base/common/outside/Config;->title:Ljava/lang/String;

    invoke-virtual {v2}, Ljava/lang/String;->hashCode()I

    move-result v2

    add-int/2addr v1, v2

    mul-int/lit8 v0, v1, 0x1f

    iget-object v2, p0, Lcom/rokid/security/sdk/base/common/outside/Config;->showToHide:Ljava/util/ArrayList;

    invoke-virtual {v2}, Ljava/util/ArrayList;->hashCode()I

    move-result v2

    add-int/2addr v0, v2

    mul-int/lit8 v1, v0, 0x1f

    iget-object v2, p0, Lcom/rokid/security/sdk/base/common/outside/Config;->hideToShow:Ljava/util/ArrayList;

    invoke-virtual {v2}, Ljava/util/ArrayList;->hashCode()I

    move-result v2

    add-int/2addr v1, v2

    mul-int/lit8 v0, v1, 0x1f

    iget-object v2, p0, Lcom/rokid/security/sdk/base/common/outside/Config;->voiceAction:Ljava/util/ArrayList;

    invoke-virtual {v2}, Ljava/util/ArrayList;->hashCode()I

    move-result v2

    add-int/2addr v0, v2

    mul-int/lit8 v1, v0, 0x1f

    iget v2, p0, Lcom/rokid/security/sdk/base/common/outside/Config;->adb:I

    invoke-static {v2}, Ljava/lang/Integer;->hashCode(I)I

    move-result v2

    add-int/2addr v1, v2

    mul-int/lit8 v0, v1, 0x1f

    iget-object v2, p0, Lcom/rokid/security/sdk/base/common/outside/Config;->showToHideApps:Ljava/util/ArrayList;

    invoke-virtual {v2}, Ljava/util/ArrayList;->hashCode()I

    move-result v2

    add-int/2addr v0, v2

    mul-int/lit8 v1, v0, 0x1f

    iget-object v2, p0, Lcom/rokid/security/sdk/base/common/outside/Config;->hideToShowApps:Ljava/util/ArrayList;

    invoke-virtual {v2}, Ljava/util/ArrayList;->hashCode()I

    move-result v2

    add-int/2addr v1, v2

    mul-int/lit8 v0, v1, 0x1f

    iget-object v2, p0, Lcom/rokid/security/sdk/base/common/outside/Config;->thirdApps:Ljava/util/ArrayList;

    invoke-virtual {v2}, Ljava/util/ArrayList;->hashCode()I

    move-result v2

    add-int/2addr v0, v2

    mul-int/lit8 v1, v0, 0x1f

    iget-object v2, p0, Lcom/rokid/security/sdk/base/common/outside/Config;->bootupApp:Lcom/rokid/security/sdk/base/common/outside/AppConfigInfo;

    if-nez v2, :cond_0

    const/4 v2, 0x0

    goto :goto_0

    :cond_0
    iget-object v2, p0, Lcom/rokid/security/sdk/base/common/outside/Config;->bootupApp:Lcom/rokid/security/sdk/base/common/outside/AppConfigInfo;

    invoke-virtual {v2}, Lcom/rokid/security/sdk/base/common/outside/AppConfigInfo;->hashCode()I

    move-result v2

    :goto_0
    add-int/2addr v1, v2

    return v1
.end method

.method public toString()Ljava/lang/String;
    .locals 3

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Config(configVersion="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget v2, p0, Lcom/rokid/security/sdk/base/common/outside/Config;->configVersion:I

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ", updateScope="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/rokid/security/sdk/base/common/outside/Config;->updateScope:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ", envType="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/rokid/security/sdk/base/common/outside/Config;->envType:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ", title="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/rokid/security/sdk/base/common/outside/Config;->title:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ", showToHide="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/rokid/security/sdk/base/common/outside/Config;->showToHide:Ljava/util/ArrayList;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ", hideToShow="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/rokid/security/sdk/base/common/outside/Config;->hideToShow:Ljava/util/ArrayList;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ", voiceAction="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/rokid/security/sdk/base/common/outside/Config;->voiceAction:Ljava/util/ArrayList;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ", adb="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget v2, p0, Lcom/rokid/security/sdk/base/common/outside/Config;->adb:I

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ", showToHideApps="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/rokid/security/sdk/base/common/outside/Config;->showToHideApps:Ljava/util/ArrayList;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ", hideToShowApps="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/rokid/security/sdk/base/common/outside/Config;->hideToShowApps:Ljava/util/ArrayList;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ", thirdApps="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/rokid/security/sdk/base/common/outside/Config;->thirdApps:Ljava/util/ArrayList;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ", bootupApp="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v1, p0, Lcom/rokid/security/sdk/base/common/outside/Config;->bootupApp:Lcom/rokid/security/sdk/base/common/outside/AppConfigInfo;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    const/16 v2, 0x29

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public writeToParcel(Landroid/os/Parcel;I)V
    .locals 2

    const-string v0, "out"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    iget v0, p0, Lcom/rokid/security/sdk/base/common/outside/Config;->configVersion:I

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeInt(I)V

    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/outside/Config;->updateScope:Ljava/lang/String;

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/outside/Config;->envType:Ljava/lang/String;

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/outside/Config;->title:Ljava/lang/String;

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/outside/Config;->showToHide:Ljava/util/ArrayList;

    check-cast v0, Ljava/util/List;

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeStringList(Ljava/util/List;)V

    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/outside/Config;->hideToShow:Ljava/util/ArrayList;

    check-cast v0, Ljava/util/List;

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeStringList(Ljava/util/List;)V

    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/outside/Config;->voiceAction:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v1

    invoke-virtual {p1, v1}, Landroid/os/Parcel;->writeInt(I)V

    invoke-virtual {v0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/rokid/security/sdk/base/common/outside/VoiceAction;

    invoke-virtual {v1, p1, p2}, Lcom/rokid/security/sdk/base/common/outside/VoiceAction;->writeToParcel(Landroid/os/Parcel;I)V

    goto :goto_0

    :cond_0
    iget v0, p0, Lcom/rokid/security/sdk/base/common/outside/Config;->adb:I

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeInt(I)V

    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/outside/Config;->showToHideApps:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v1

    invoke-virtual {p1, v1}, Landroid/os/Parcel;->writeInt(I)V

    invoke-virtual {v0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_1
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/rokid/security/sdk/base/common/outside/AppConfigInfo;

    invoke-virtual {v1, p1, p2}, Lcom/rokid/security/sdk/base/common/outside/AppConfigInfo;->writeToParcel(Landroid/os/Parcel;I)V

    goto :goto_1

    :cond_1
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/outside/Config;->hideToShowApps:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v1

    invoke-virtual {p1, v1}, Landroid/os/Parcel;->writeInt(I)V

    invoke-virtual {v0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_2
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_2

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/rokid/security/sdk/base/common/outside/AppConfigInfo;

    invoke-virtual {v1, p1, p2}, Lcom/rokid/security/sdk/base/common/outside/AppConfigInfo;->writeToParcel(Landroid/os/Parcel;I)V

    goto :goto_2

    :cond_2
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/outside/Config;->thirdApps:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v1

    invoke-virtual {p1, v1}, Landroid/os/Parcel;->writeInt(I)V

    invoke-virtual {v0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_3
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_3

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/rokid/security/sdk/base/common/outside/AppConfigInfo;

    invoke-virtual {v1, p1, p2}, Lcom/rokid/security/sdk/base/common/outside/AppConfigInfo;->writeToParcel(Landroid/os/Parcel;I)V

    goto :goto_3

    :cond_3
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/outside/Config;->bootupApp:Lcom/rokid/security/sdk/base/common/outside/AppConfigInfo;

    if-nez v0, :cond_4

    const/4 v0, 0x0

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeInt(I)V

    goto :goto_4

    :cond_4
    const/4 v1, 0x1

    invoke-virtual {p1, v1}, Landroid/os/Parcel;->writeInt(I)V

    invoke-virtual {v0, p1, p2}, Lcom/rokid/security/sdk/base/common/outside/AppConfigInfo;->writeToParcel(Landroid/os/Parcel;I)V

    :goto_4
    return-void
.end method
