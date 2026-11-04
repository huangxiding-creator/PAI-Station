.class public final synthetic Lio/minio/GetPresignedObjectUrlArgs$Builder$$ExternalSyntheticLambda1;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Ljava/util/function/Consumer;


# instance fields
.field public final synthetic f$0:Lio/minio/http/Method;


# direct methods
.method public synthetic constructor <init>(Lio/minio/http/Method;)V
    .locals 0

    .line 0
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lio/minio/GetPresignedObjectUrlArgs$Builder$$ExternalSyntheticLambda1;->f$0:Lio/minio/http/Method;

    return-void
.end method


# virtual methods
.method public final accept(Ljava/lang/Object;)V
    .locals 1

    .line 0
    iget-object v0, p0, Lio/minio/GetPresignedObjectUrlArgs$Builder$$ExternalSyntheticLambda1;->f$0:Lio/minio/http/Method;

    check-cast p1, Lio/minio/GetPresignedObjectUrlArgs;

    invoke-static {v0, p1}, Lio/minio/GetPresignedObjectUrlArgs$Builder;->lambda$method$0(Lio/minio/http/Method;Lio/minio/GetPresignedObjectUrlArgs;)V

    return-void
.end method
