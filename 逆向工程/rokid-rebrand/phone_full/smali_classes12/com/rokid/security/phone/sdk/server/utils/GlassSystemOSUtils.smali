.class public final Lcom/rokid/security/phone/sdk/server/utils/GlassSystemOSUtils;
.super Ljava/lang/Object;
.source "GlassSystemOSUtils.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u0018\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0010\u000b\n\u0000\n\u0002\u0010\u000e\n\u0000\u0008\u00c6\u0002\u0018\u00002\u00020\u0001B\u0007\u0008\u0002\u00a2\u0006\u0002\u0010\u0002J\u0006\u0010\u0003\u001a\u00020\u0004J\u000e\u0010\u0003\u001a\u00020\u00042\u0006\u0010\u0005\u001a\u00020\u0006R\u000e\u0010\u0003\u001a\u00020\u0004X\u0082\u000e\u00a2\u0006\u0002\n\u0000\u00a8\u0006\u0007"
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/server/utils/GlassSystemOSUtils;",
        "",
        "()V",
        "isPoliceOS",
        "",
        "glass3Subtype",
        "",
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


# static fields
.field public static final INSTANCE:Lcom/rokid/security/phone/sdk/server/utils/GlassSystemOSUtils;

.field private static volatile isPoliceOS:Z


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Lcom/rokid/security/phone/sdk/server/utils/GlassSystemOSUtils;

    invoke-direct {v0}, Lcom/rokid/security/phone/sdk/server/utils/GlassSystemOSUtils;-><init>()V

    sput-object v0, Lcom/rokid/security/phone/sdk/server/utils/GlassSystemOSUtils;->INSTANCE:Lcom/rokid/security/phone/sdk/server/utils/GlassSystemOSUtils;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 6
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final isPoliceOS()Z
    .locals 1

    .line 15
    sget-boolean v0, Lcom/rokid/security/phone/sdk/server/utils/GlassSystemOSUtils;->isPoliceOS:Z

    return v0
.end method

.method public final isPoliceOS(Ljava/lang/String;)Z
    .locals 1
    .param p1, "glass3Subtype"    # Ljava/lang/String;

    const-string v0, "glass3Subtype"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 10
    const-string v0, "c692851fa858ed977171be9c8af6205a"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    sput-boolean v0, Lcom/rokid/security/phone/sdk/server/utils/GlassSystemOSUtils;->isPoliceOS:Z

    .line 11
    sget-boolean v0, Lcom/rokid/security/phone/sdk/server/utils/GlassSystemOSUtils;->isPoliceOS:Z

    return v0
.end method
