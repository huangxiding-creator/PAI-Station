.class public final Lcom/rokid/security/sdk/base/common/OfflineRecAPI$Companion;
.super Ljava/lang/Object;
.source "OfflineRecExtra.kt"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/rokid/security/sdk/base/common/OfflineRecAPI;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "Companion"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u0014\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0002\u0008\u0004\u0008\u0086\u0003\u0018\u00002\u00020\u0001B\u0007\u0008\u0002\u00a2\u0006\u0002\u0010\u0002R\u000e\u0010\u0003\u001a\u00020\u0004X\u0086T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0005\u001a\u00020\u0004X\u0086T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0006\u001a\u00020\u0004X\u0086T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0007\u001a\u00020\u0004X\u0086T\u00a2\u0006\u0002\n\u0000\u00a8\u0006\u0008"
    }
    d2 = {
        "Lcom/rokid/security/sdk/base/common/OfflineRecAPI$Companion;",
        "",
        "()V",
        "Check_Lib_Response",
        "",
        "Check_Update_Lib_Version",
        "RequestPersonInfo",
        "RequestPersonInfo_Response",
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
.field static final synthetic $$INSTANCE:Lcom/rokid/security/sdk/base/common/OfflineRecAPI$Companion;

.field public static final Check_Lib_Response:Ljava/lang/String; = "Check_Lib_Response"

.field public static final Check_Update_Lib_Version:Ljava/lang/String; = "Check_Update_Lib_Version"

.field public static final RequestPersonInfo:Ljava/lang/String; = "RequestPersonInfo"

.field public static final RequestPersonInfo_Response:Ljava/lang/String; = "RequestPersonInfo_Response"


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Lcom/rokid/security/sdk/base/common/OfflineRecAPI$Companion;

    invoke-direct {v0}, Lcom/rokid/security/sdk/base/common/OfflineRecAPI$Companion;-><init>()V

    sput-object v0, Lcom/rokid/security/sdk/base/common/OfflineRecAPI$Companion;->$$INSTANCE:Lcom/rokid/security/sdk/base/common/OfflineRecAPI$Companion;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 61
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method
