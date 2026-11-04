.class public final Lcom/rokid/glasses/transport/sdk/api/callback/IResultKt$fold$1;
.super Lkotlin/jvm/internal/Lambda;
.source "IResult.kt"

# interfaces
.implements Lkotlin/jvm/functions/Function1;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/glasses/transport/sdk/api/callback/IResultKt;->fold-DM99JKI$default(Ljava/lang/Object;Lkotlin/jvm/functions/Function1;Lkotlin/jvm/functions/Function1;ILjava/lang/Object;)Ljava/lang/Object;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = null
.end annotation

.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nIResult.kt\nKotlin\n*S Kotlin\n*F\n+ 1 IResult.kt\ncom/rokid/glasses/transport/sdk/api/callback/IResultKt$fold$1\n*L\n1#1,337:1\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u0010\n\u0000\n\u0002\u0010\u0001\n\u0002\u0008\u0003\n\u0002\u0018\u0002\n\u0000\u0010\u0000\u001a\u0004\u0018\u00010\u0001\"\u0004\u0008\u0000\u0010\u0002\"\u0004\u0008\u0001\u0010\u00032\u0006\u0010\u0004\u001a\u00020\u0005H\n\u00a2\u0006\u0002\u0008\u0006"
    }
    d2 = {
        "<anonymous>",
        "",
        "T",
        "R",
        "it",
        "Lcom/rokid/glasses/transport/sdk/api/callback/IException;",
        "invoke"
    }
    k = 0x3
    mv = {
        0x1,
        0x8,
        0x0
    }
    xi = 0xb0
.end annotation


# static fields
.field public static final INSTANCE:Lcom/rokid/glasses/transport/sdk/api/callback/IResultKt$fold$1;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Lcom/rokid/glasses/transport/sdk/api/callback/IResultKt$fold$1;

    invoke-direct {v0}, Lcom/rokid/glasses/transport/sdk/api/callback/IResultKt$fold$1;-><init>()V

    sput-object v0, Lcom/rokid/glasses/transport/sdk/api/callback/IResultKt$fold$1;->INSTANCE:Lcom/rokid/glasses/transport/sdk/api/callback/IResultKt$fold$1;

    return-void
.end method

.method public constructor <init>()V
    .locals 1

    const/4 v0, 0x1

    invoke-direct {p0, v0}, Lkotlin/jvm/internal/Lambda;-><init>(I)V

    return-void
.end method


# virtual methods
.method public bridge synthetic invoke(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 1
    .param p1, "p1"    # Ljava/lang/Object;

    .line 214
    move-object v0, p1

    check-cast v0, Lcom/rokid/glasses/transport/sdk/api/callback/IException;

    invoke-virtual {p0, v0}, Lcom/rokid/glasses/transport/sdk/api/callback/IResultKt$fold$1;->invoke(Lcom/rokid/glasses/transport/sdk/api/callback/IException;)Ljava/lang/Void;

    move-result-object v0

    return-object v0
.end method

.method public final invoke(Lcom/rokid/glasses/transport/sdk/api/callback/IException;)Ljava/lang/Void;
    .locals 2
    .param p1, "it"    # Lcom/rokid/glasses/transport/sdk/api/callback/IException;

    const-string v0, "it"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 215
    const-string v0, "result"

    invoke-virtual {p1}, Lcom/rokid/glasses/transport/sdk/api/callback/IException;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 216
    const/4 v0, 0x0

    return-object v0
.end method
