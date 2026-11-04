.class public final Lcom/rokid/glasses/transport/sdk/api/engine/api/IGlassesEngine$DefaultImpls;
.super Ljava/lang/Object;
.source "IGlassesEngine.kt"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/rokid/glasses/transport/sdk/api/engine/api/IGlassesEngine;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "DefaultImpls"
.end annotation

.annotation runtime Lkotlin/Metadata;
    k = 0x3
    mv = {
        0x1,
        0x8,
        0x0
    }
    xi = 0x30
.end annotation


# direct methods
.method public static synthetic initSDK$default(Lcom/rokid/glasses/transport/sdk/api/engine/api/IGlassesEngine;ZLjava/lang/String;ILkotlin/jvm/functions/Function1;ILjava/lang/Object;)V
    .locals 0

    .line 20
    if-nez p6, :cond_1

    and-int/lit8 p5, p5, 0x2

    if-eqz p5, :cond_0

    .line 22
    const-string p2, ""

    .line 20
    :cond_0
    invoke-interface {p0, p1, p2, p3, p4}, Lcom/rokid/glasses/transport/sdk/api/engine/api/IGlassesEngine;->initSDK(ZLjava/lang/String;ILkotlin/jvm/functions/Function1;)V

    return-void

    :cond_1
    new-instance p0, Ljava/lang/UnsupportedOperationException;

    const-string p1, "Super calls with default arguments not supported in this target, function: initSDK"

    invoke-direct {p0, p1}, Ljava/lang/UnsupportedOperationException;-><init>(Ljava/lang/String;)V

    throw p0
.end method
