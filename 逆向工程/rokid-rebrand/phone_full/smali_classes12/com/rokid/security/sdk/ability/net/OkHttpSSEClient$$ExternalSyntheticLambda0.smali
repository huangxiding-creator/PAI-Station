.class public final synthetic Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient$$ExternalSyntheticLambda0;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Ljava/lang/Runnable;


# instance fields
.field public final synthetic f$0:Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;

.field public final synthetic f$1:J

.field public final synthetic f$2:Lokhttp3/Request;

.field public final synthetic f$3:Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient$SSECallback;

.field public final synthetic f$4:I

.field public final synthetic f$5:I


# direct methods
.method public synthetic constructor <init>(Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;JLokhttp3/Request;Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient$SSECallback;II)V
    .locals 0

    .line 0
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient$$ExternalSyntheticLambda0;->f$0:Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;

    iput-wide p2, p0, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient$$ExternalSyntheticLambda0;->f$1:J

    iput-object p4, p0, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient$$ExternalSyntheticLambda0;->f$2:Lokhttp3/Request;

    iput-object p5, p0, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient$$ExternalSyntheticLambda0;->f$3:Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient$SSECallback;

    iput p6, p0, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient$$ExternalSyntheticLambda0;->f$4:I

    iput p7, p0, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient$$ExternalSyntheticLambda0;->f$5:I

    return-void
.end method


# virtual methods
.method public final run()V
    .locals 7

    .line 0
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient$$ExternalSyntheticLambda0;->f$0:Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;

    iget-wide v1, p0, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient$$ExternalSyntheticLambda0;->f$1:J

    iget-object v3, p0, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient$$ExternalSyntheticLambda0;->f$2:Lokhttp3/Request;

    iget-object v4, p0, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient$$ExternalSyntheticLambda0;->f$3:Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient$SSECallback;

    iget v5, p0, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient$$ExternalSyntheticLambda0;->f$4:I

    iget v6, p0, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient$$ExternalSyntheticLambda0;->f$5:I

    invoke-static/range {v0 .. v6}, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;->$r8$lambda$eOgFCK_rknZXfYtUk_KScTSbbIE(Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;JLokhttp3/Request;Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient$SSECallback;II)V

    return-void
.end method
