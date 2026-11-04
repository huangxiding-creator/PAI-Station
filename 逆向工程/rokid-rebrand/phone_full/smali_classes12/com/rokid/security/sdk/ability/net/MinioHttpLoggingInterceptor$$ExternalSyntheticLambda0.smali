.class public final synthetic Lcom/rokid/security/sdk/ability/net/MinioHttpLoggingInterceptor$$ExternalSyntheticLambda0;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Lokhttp3/Interceptor;


# direct methods
.method public synthetic constructor <init>()V
    .locals 0

    .line 0
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final intercept(Lokhttp3/Interceptor$Chain;)Lokhttp3/Response;
    .locals 0

    .line 0
    invoke-static {p1}, Lcom/rokid/security/sdk/ability/net/MinioHttpLoggingInterceptor;->$r8$lambda$pkLYi0MwFI4AlgoQN-QEcNcsoAs(Lokhttp3/Interceptor$Chain;)Lokhttp3/Response;

    move-result-object p1

    return-object p1
.end method
