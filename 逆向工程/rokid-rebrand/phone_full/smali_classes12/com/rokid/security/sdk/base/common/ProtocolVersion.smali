.class public final Lcom/rokid/security/sdk/base/common/ProtocolVersion;
.super Ljava/lang/Object;
.source "RkBaseData.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u001c\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0002\u0008\u0005\n\u0002\u0010\u000b\n\u0002\u0008\u0004\u0008\u00c6\u0002\u0018\u00002\u00020\u0001B\u0007\u0008\u0002\u00a2\u0006\u0002\u0010\u0002J\u000e\u0010\t\u001a\u00020\n2\u0006\u0010\u000b\u001a\u00020\u0004J\u000e\u0010\u000c\u001a\u00020\n2\u0006\u0010\u000b\u001a\u00020\u0004J\u000e\u0010\r\u001a\u00020\n2\u0006\u0010\u000b\u001a\u00020\u0004R\u000e\u0010\u0003\u001a\u00020\u0004X\u0086T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0005\u001a\u00020\u0004X\u0086T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0006\u001a\u00020\u0004X\u0086T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0007\u001a\u00020\u0004X\u0086T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0008\u001a\u00020\u0004X\u0086T\u00a2\u0006\u0002\n\u0000\u00a8\u0006\u000e"
    }
    d2 = {
        "Lcom/rokid/security/sdk/base/common/ProtocolVersion;",
        "",
        "()V",
        "VERSION_1",
        "",
        "VERSION_2",
        "VERSION_3",
        "VERSION_4",
        "VERSION_5",
        "isProtocolVersionEqualVersion",
        "",
        "targetVersion",
        "isProtocolVersionHighVersion",
        "isProtocolVersionLowVersion",
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
.field public static final INSTANCE:Lcom/rokid/security/sdk/base/common/ProtocolVersion;

.field public static final VERSION_1:Ljava/lang/String; = "1.0"

.field public static final VERSION_2:Ljava/lang/String; = "2.0"

.field public static final VERSION_3:Ljava/lang/String; = "3.0"

.field public static final VERSION_4:Ljava/lang/String; = "4.0"

.field public static final VERSION_5:Ljava/lang/String; = "5.0"


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Lcom/rokid/security/sdk/base/common/ProtocolVersion;

    invoke-direct {v0}, Lcom/rokid/security/sdk/base/common/ProtocolVersion;-><init>()V

    sput-object v0, Lcom/rokid/security/sdk/base/common/ProtocolVersion;->INSTANCE:Lcom/rokid/security/sdk/base/common/ProtocolVersion;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 10
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final isProtocolVersionEqualVersion(Ljava/lang/String;)Z
    .locals 1
    .param p1, "targetVersion"    # Ljava/lang/String;

    const-string/jumbo v0, "targetVersion"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 34
    const-string v0, "5.0"

    invoke-virtual {v0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    return v0
.end method

.method public final isProtocolVersionHighVersion(Ljava/lang/String;)Z
    .locals 2
    .param p1, "targetVersion"    # Ljava/lang/String;

    const-string/jumbo v0, "targetVersion"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 28
    const-string v0, "5.0"

    invoke-static {v0}, Ljava/lang/Float;->parseFloat(Ljava/lang/String;)F

    move-result v0

    invoke-static {p1}, Ljava/lang/Float;->parseFloat(Ljava/lang/String;)F

    move-result v1

    cmpl-float v0, v0, v1

    if-lez v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method public final isProtocolVersionLowVersion(Ljava/lang/String;)Z
    .locals 2
    .param p1, "targetVersion"    # Ljava/lang/String;

    const-string/jumbo v0, "targetVersion"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 22
    const-string v0, "5.0"

    invoke-static {v0}, Ljava/lang/Float;->parseFloat(Ljava/lang/String;)F

    move-result v0

    invoke-static {p1}, Ljava/lang/Float;->parseFloat(Ljava/lang/String;)F

    move-result v1

    cmpg-float v0, v0, v1

    if-gez v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method
