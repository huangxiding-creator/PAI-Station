.class final Lcom/rokid/security/phone/sdk/server/inspection/FloatingBallView$bgGreen$2;
.super Lkotlin/jvm/internal/Lambda;
.source "FloatingBallView.kt"

# interfaces
.implements Lkotlin/jvm/functions/Function0;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/security/phone/sdk/server/inspection/FloatingBallView;-><init>(Landroid/content/Context;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x18
    name = null
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lkotlin/jvm/internal/Lambda;",
        "Lkotlin/jvm/functions/Function0<",
        "Landroid/graphics/drawable/GradientDrawable;",
        ">;"
    }
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u0008\n\u0000\n\u0002\u0018\u0002\n\u0000\u0010\u0000\u001a\u00020\u0001H\n\u00a2\u0006\u0002\u0008\u0002"
    }
    d2 = {
        "<anonymous>",
        "Landroid/graphics/drawable/GradientDrawable;",
        "invoke"
    }
    k = 0x3
    mv = {
        0x1,
        0x8,
        0x0
    }
    xi = 0x30
.end annotation


# static fields
.field public static final INSTANCE:Lcom/rokid/security/phone/sdk/server/inspection/FloatingBallView$bgGreen$2;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Lcom/rokid/security/phone/sdk/server/inspection/FloatingBallView$bgGreen$2;

    invoke-direct {v0}, Lcom/rokid/security/phone/sdk/server/inspection/FloatingBallView$bgGreen$2;-><init>()V

    sput-object v0, Lcom/rokid/security/phone/sdk/server/inspection/FloatingBallView$bgGreen$2;->INSTANCE:Lcom/rokid/security/phone/sdk/server/inspection/FloatingBallView$bgGreen$2;

    return-void
.end method

.method constructor <init>()V
    .locals 1

    const/4 v0, 0x0

    invoke-direct {p0, v0}, Lkotlin/jvm/internal/Lambda;-><init>(I)V

    return-void
.end method


# virtual methods
.method public final invoke()Landroid/graphics/drawable/GradientDrawable;
    .locals 5

    .line 29
    new-instance v0, Landroid/graphics/drawable/GradientDrawable;

    invoke-direct {v0}, Landroid/graphics/drawable/GradientDrawable;-><init>()V

    move-object v1, v0

    .local v1, "$this$invoke_u24lambda_u240":Landroid/graphics/drawable/GradientDrawable;
    const/4 v2, 0x0

    .line 30
    .local v2, "$i$a$-apply-FloatingBallView$bgGreen$2$1":I
    const/4 v3, 0x1

    invoke-virtual {v1, v3}, Landroid/graphics/drawable/GradientDrawable;->setShape(I)V

    .line 31
    nop

    .line 32
    const-string v3, "#4CAF50"

    invoke-static {v3}, Landroid/graphics/Color;->parseColor(Ljava/lang/String;)I

    move-result v3

    .line 33
    const-string v4, "#8BC34A"

    invoke-static {v4}, Landroid/graphics/Color;->parseColor(Ljava/lang/String;)I

    move-result v4

    filled-new-array {v3, v4}, [I

    move-result-object v3

    .line 32
    nop

    .line 31
    invoke-virtual {v1, v3}, Landroid/graphics/drawable/GradientDrawable;->setColors([I)V

    .line 35
    nop

    .line 29
    .end local v1    # "$this$invoke_u24lambda_u240":Landroid/graphics/drawable/GradientDrawable;
    .end local v2    # "$i$a$-apply-FloatingBallView$bgGreen$2$1":I
    return-object v0
.end method

.method public bridge synthetic invoke()Ljava/lang/Object;
    .locals 1

    .line 28
    invoke-virtual {p0}, Lcom/rokid/security/phone/sdk/server/inspection/FloatingBallView$bgGreen$2;->invoke()Landroid/graphics/drawable/GradientDrawable;

    move-result-object v0

    return-object v0
.end method
