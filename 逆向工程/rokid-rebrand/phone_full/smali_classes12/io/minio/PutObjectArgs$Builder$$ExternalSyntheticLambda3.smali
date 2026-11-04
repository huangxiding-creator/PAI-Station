.class public final synthetic Lio/minio/PutObjectArgs$Builder$$ExternalSyntheticLambda3;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Ljava/util/function/Consumer;


# instance fields
.field public final synthetic f$0:I


# direct methods
.method public synthetic constructor <init>(I)V
    .locals 0

    .line 0
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput p1, p0, Lio/minio/PutObjectArgs$Builder$$ExternalSyntheticLambda3;->f$0:I

    return-void
.end method


# virtual methods
.method public final accept(Ljava/lang/Object;)V
    .locals 1

    .line 0
    iget v0, p0, Lio/minio/PutObjectArgs$Builder$$ExternalSyntheticLambda3;->f$0:I

    check-cast p1, Lio/minio/PutObjectArgs;

    invoke-static {v0, p1}, Lio/minio/PutObjectArgs$Builder;->lambda$setStream$3(ILio/minio/PutObjectArgs;)V

    return-void
.end method
